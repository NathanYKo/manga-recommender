# web/app.py
from flask import Flask, render_template, request, session, redirect, url_for, jsonify
import os
import logging
import hashlib
import secrets
from datetime import datetime
from models.hybrid import HybridRecommender
from utils.config import config
from utils.helpers import execute_query

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger('manga_recommender.webapp')

# Initialize Flask app
app = Flask(__name__)
app.secret_key = secrets.token_hex(16)  # Generate a secure secret key

# Initialize recommender system (lazy loading)
recommender = None

def get_recommender():
    """Get or initialize the recommender system"""
    global recommender
    if recommender is None:
        logger.info("Initializing recommender system...")
        recommender = HybridRecommender(
            content_weight=config.get('content_weight', 0.5),
            collab_weight=config.get('collab_weight', 0.5)
        )
        recommender.fit()
    return recommender

# Authentication functions
def hash_password(password, salt=None):
    """Hash a password for storing"""
    if salt is None:
        salt = secrets.token_hex(8)
    pw_hash = hashlib.pbkdf2_hmac('sha256', password.encode('utf-8'), salt.encode('utf-8'), 100000)
    return salt + ":" + pw_hash.hex()

def verify_password(stored_password, provided_password):
    """Verify a stored password against one provided by user"""
    salt, stored_hash = stored_password.split(':')
    pw_hash = hashlib.pbkdf2_hmac('sha256', provided_password.encode('utf-8'), salt.encode('utf-8'), 100000)
    return pw_hash.hex() == stored_hash

def get_user(username):
    """Get user data from database"""
    query = "SELECT user_id, username, password FROM users WHERE username = %s"
    result = execute_query(query, (username,), fetch_one=True)
    return result

def create_user(username, password):
    """Create a new user in the database"""
    hashed_password = hash_password(password)
    query = "INSERT INTO users (username, password, created_at) VALUES (%s, %s, %s) RETURNING user_id"
    created_at = datetime.now()
    result = execute_query(query, (username, hashed_password, created_at), fetch_one=True)
    return result['user_id'] if result else None

# Routes
@app.route('/')
def index():
    """Home page route"""
    # Get popular manga for homepage display
    query = """
    SELECT manga_id, title, score, img_url, synopsis 
    FROM manga 
    WHERE members > 50000 
    ORDER BY score DESC 
    LIMIT 10
    """
    popular_manga = execute_query(query)
    
    # Check if user is logged in
    user_id = session.get('user_id')
    username = session.get('username')
    
    # Get personalized recommendations if user is logged in
    personalized_recs = []
    if user_id:
        try:
            rec_system = get_recommender()
            personalized_recs = rec_system.get_personalized_recommendations(user_id, top_n=6)
            
            # If we have recommendations, fetch additional details
            if not personalized_recs.empty:
                # Convert manga_ids to list
                manga_ids = personalized_recs['manga_id'].tolist()
                
                # Get additional details for these manga
                placeholders = ', '.join(['%s'] * len(manga_ids))
                query = f"""
                SELECT manga_id, img_url, synopsis 
                FROM manga 
                WHERE manga_id IN ({placeholders})
                """
                details = execute_query(query, manga_ids)
                
                # Convert to dictionary for easy lookup
                details_dict = {row['manga_id']: row for row in details}
                
                # Add details to recommendations
                for i, row in personalized_recs.iterrows():
                    manga_id = row['manga_id']
                    if manga_id in details_dict:
                        personalized_recs.at[i, 'img_url'] = details_dict[manga_id]['img_url']
                        personalized_recs.at[i, 'synopsis'] = details_dict[manga_id]['synopsis']
        
        except Exception as e:
            logger.error(f"Error getting personalized recommendations: {e}")
    
    return render_template(
        'index.html', 
        popular_manga=popular_manga,
        personalized_recs=personalized_recs.to_dict('records') if not personalized_recs.empty else [],
        user_id=user_id,
        username=username
    )

@app.route('/manga/<int:manga_id>')
def manga_details(manga_id):
    """Manga details page"""
    # Get manga details
    query = "SELECT * FROM manga WHERE manga_id = %s"
    manga = execute_query(query, (manga_id,), fetch_one=True)
    
    if not manga:
        return render_template('404.html', message="Manga not found"), 404
    
    # Get similar manga recommendations
    similar_manga = []
    try:
        rec_system = get_recommender()
        recommendations = rec_system.get_recommendations_by_id(manga_id, top_n=6)
        
        if not recommendations.empty:
            # Get additional details for the recommended manga
            manga_ids = recommendations['manga_id'].tolist()
            placeholders = ', '.join(['%s'] * len(manga_ids))
            query = f"""
            SELECT manga_id, title, img_url, score 
            FROM manga 
            WHERE manga_id IN ({placeholders})
            """
            similar_manga = execute_query(query, manga_ids)
    except Exception as e:
        logger.error(f"Error getting recommendations: {e}")
    
    # Get user's rating if logged in
    user_rating = None
    if 'user_id' in session:
        query = "SELECT rating FROM ratings WHERE user_id = %s AND manga_id = %s"
        result = execute_query(query, (session['user_id'], manga_id), fetch_one=True)
        user_rating = result['rating'] if result else None
    
    return render_template(
        'manga_details.html',
        manga=manga,
        similar_manga=similar_manga,
        user_rating=user_rating,
        user_id=session.get('user_id'),
        username=session.get('username')
    )

@app.route('/search')
def search():
    """Search page"""
    query_text = request.args.get('q', '')
    genre = request.args.get('genre', '')
    sort_by = request.args.get('sort', 'score')
    page = int(request.args.get('page', 1))
    per_page = 20
    
    # Base SQL query
    sql_query = """
    SELECT manga_id, title, score, img_url, genres, members
    FROM manga
    WHERE 1=1
    """
    params = []
    
    # Add search conditions
    if query_text:
        sql_query += " AND (title ILIKE %s OR alternative_titles ILIKE %s)"
        params.extend([f'%{query_text}%', f'%{query_text}%'])
    
    if genre:
        sql_query += " AND genres ILIKE %s"
        params.append(f'%{genre}%')
    
    # Add sorting
    if sort_by == 'score':
        sql_query += " ORDER BY score DESC"
    elif sort_by == 'popularity':
        sql_query += " ORDER BY members DESC"
    elif sort_by == 'title':
        sql_query += " ORDER BY title ASC"
    
    # Add pagination
    offset = (page - 1) * per_page
    sql_query += " LIMIT %s OFFSET %s"
    params.extend([per_page, offset])
    
    # Execute query
    results = execute_query(sql_query, params)
    
    # Get total count for pagination
    count_query = """
    SELECT COUNT(*) as total
    FROM manga
    WHERE 1=1
    """
    count_params = []
    
    if query_text:
        count_query += " AND (title ILIKE %s OR alternative_titles ILIKE %s)"
        count_params.extend([f'%{query_text}%', f'%{query_text}%'])
    
    if genre:
        count_query += " AND genres ILIKE %s"
        count_params.append(f'%{genre}%')
    
    count_result = execute_query(count_query, count_params, fetch_one=True)
    total = count_result['total']
    total_pages = (total + per_page - 1) // per_page
    
    # Get available genres for filter
    genres_query = """
    SELECT DISTINCT unnest(string_to_array(genres, ', ')) as genre
    FROM manga
    ORDER BY genre
    """
    genres = execute_query(genres_query)
    genres = [g['genre'] for g in genres]
    
    return render_template(
        'search.html',
        results=results,
        query=query_text,
        genre=genre,
        sort_by=sort_by,
        page=page,
        total_pages=total_pages,
        genres=genres,
        user_id=session.get('user_id'),
        username=session.get('username')
    )

@app.route('/login', methods=['GET', 'POST'])
def login():
    """Login page"""
    if request.method == 'POST':
        username = request.form.get('username')
        password = request.form.get('password')
        
        if not username or not password:
            return render_template('login.html', error="Username and password are required")
        
        user = get_user(username)
        if not user or not verify_password(user['password'], password):
            return render_template('login.html', error="Invalid username or password")
        
        # Set session data
        session['user_id'] = user['user_id']
        session['username'] = user['username']
        
        # Redirect to home or next page
        next_page = request.args.get('next', 'index')
        return redirect(url_for(next_page))
    
    return render_template('login.html')

@app.route('/register', methods=['GET', 'POST'])
def register():
    """Registration page"""
    if request.method == 'POST':
        username = request.form.get('username')
        password = request.form.get('password')
        confirm_password = request.form.get('confirm_password')
        
        # Validate inputs
        if not username or not password:
            return render_template('register.html', error="Username and password are required")
        
        if password != confirm_password:
            return render_template('register.html', error="Passwords do not match")
        
        # Check if username exists
        existing_user = get_user(username)
        if existing_user:
            return render_template('register.html', error="Username already exists")
        
        # Create user
        user_id = create_user(username, password)
        if not user_id:
            return render_template('register.html', error="Failed to create user")
        
        # Set session data
        session['user_id'] = user_id
        session['username'] = username
        
        # Redirect to home
        return redirect(url_for('index'))
    
    return render_template('register.html')

@app.route('/logout')
def logout():
    """Logout the user"""
    session.clear()
    return redirect(url_for('index'))

@app.route('/rate', methods=['POST'])
def rate_manga():
    """API endpoint to rate a manga"""
    if 'user_id' not in session:
        return jsonify({'success': False, 'message': 'You must be logged in to rate'}), 401
    
    manga_id = request.form.get('manga_id')
    rating = request.form.get('rating')
    
    if not manga_id or not rating:
        return jsonify({'success': False, 'message': 'Missing manga_id or rating'}), 400
    
    try:
        rating = int(rating)
        if rating < 1 or rating > 10:
            return jsonify({'success': False, 'message': 'Rating must be between 1 and 10'}), 400
        
        # Check if user has already rated this manga
        query = "SELECT rating_id FROM ratings WHERE user_id = %s AND manga_id = %s"
        existing = execute_query(query, (session['user_id'], manga_id), fetch_one=True)
        
        if existing:
            # Update existing rating
            query = "UPDATE ratings SET rating = %s, updated_at = %s WHERE rating_id = %s"
            execute_query(query, (rating, datetime.now(), existing['rating_id']))
        else:
            # Insert new rating
            query = """
            INSERT INTO ratings (user_id, manga_id, rating, created_at) 
            VALUES (%s, %s, %s, %s)
            """
            execute_query(query, (session['user_id'], manga_id, rating, datetime.now()))
        
        return jsonify({'success': True})
    
    except Exception as e:
        logger.error(f"Error rating manga: {e}")
        return jsonify({'success': False, 'message': 'Failed to save rating'}), 500

@app.route('/profile')
def profile():
    """User profile page"""
    if 'user_id' not in session:
        return redirect(url_for('login', next='profile'))
    
    # Get user's ratings
    query = """
    SELECT r.manga_id, r.rating, r.created_at, m.title, m.img_url
    FROM ratings r
    JOIN manga m ON r.manga_id = m.manga_id
    WHERE r.user_id = %s
    ORDER BY r.created_at DESC
    """
    ratings = execute_query(query, (session['user_id'],))
    
    # Get personalized recommendations
    personalized_recs = []
    try:
        rec_system = get_recommender()
        recs = rec_system.get_personalized_recommendations(session['user_id'], top_n=10)
        
        if not recs.empty:
            # Get additional details for these manga
            manga_ids = recs['manga_id'].tolist()
            placeholders = ', '.join(['%s'] * len(manga_ids))
            query = f"""
            SELECT manga_id, title, img_url, score 
            FROM manga 
            WHERE manga_id IN ({placeholders})
            """
            personalized_recs = execute_query(query, manga_ids)
    except Exception as e:
        logger.error(f"Error getting personalized recommendations: {e}")
    
    return render_template(
        'profile.html',
        ratings=ratings,
        recommendations=personalized_recs,
        username=session.get('username')
    )

@app.route('/api/recommendations/<int:manga_id>')
def api_recommendations(manga_id):
    """API endpoint to get recommendations for a manga"""
    try:
        rec_system = get_recommender()
        recommendations = rec_system.get_recommendations_by_id(manga_id, top_n=10)
        
        if recommendations.empty:
            return jsonify([])
        
        # Convert to list of dictionaries
        result = recommendations.to_dict('records')
        return jsonify(result)
    
    except Exception as e:
        logger.error(f"Error getting recommendations: {e}")
        return jsonify({'error': str(e)}), 500

@app.route('/api/user/recommendations')
def api_user_recommendations():
    """API endpoint to get personalized recommendations for the current user"""
    if 'user_id' not in session:
        return jsonify({'error': 'Not logged in'}), 401
    
    try:
        rec_system = get_recommender()
        recommendations = rec_system.get_personalized_recommendations(session['user_id'], top_n=10)
        
        if recommendations.empty:
            return jsonify([])
        
        # Convert to list of dictionaries
        result = recommendations.to_dict('records')
        return jsonify(result)
    
    except Exception as e:
        logger.error(f"Error getting recommendations: {e}")
        return jsonify({'error': str(e)}), 500

@app.errorhandler(404)
def page_not_found(e):
    """Handle 404 errors"""
    return render_template('404.html'), 404

@app.errorhandler(500)
def server_error(e):
    """Handle 500 errors"""
    logger.error(f"Server error: {e}")
    return render_template('500.html'), 500

# Custom template filters
@app.template_filter('truncate_text')
def truncate_text(text, length=150):
    """Truncate text to specified length"""
    if not text:
        return ""
    if len(text) <= length:
        return text
    return text[:length].rsplit(' ', 1)[0] + '...'

@app.template_filter('format_date')
def format_date(date):
    """Format datetime to readable string"""
    if not date:
        return ""
    return date.strftime("%b %d, %Y")

# Run the app
if __name__ == '__main__':
    # Check if templates folder exists
    if not os.path.exists(os.path.join(app.root_path, 'templates')):
        logger.warning("Templates folder not found. Creating...")
        os.makedirs(os.path.join(app.root_path, 'templates'))
    
    # Check if static folder exists
    if not os.path.exists(os.path.join(app.root_path, 'static')):
        logger.warning("Static folder not found. Creating...")
        os.makedirs(os.path.join(app.root_path, 'static'))
    
    # Run in debug mode for development
    debug_mode = config.get('debug', True)
    app.run(debug=debug_mode, host='0.0.0.0', port=5000)