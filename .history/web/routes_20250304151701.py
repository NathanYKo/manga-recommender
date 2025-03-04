# web/routes.py
from flask import render_template, request, session, redirect, url_for, jsonify
import logging
from datetime import datetime
from utils.auth import get_user, create_user, verify_password
from utils.helpers import execute_query

# Configure logging
logger = logging.getLogger('manga_recommender.routes')

def register_routes(app, get_recommender):
    """
    Register all routes for the Manga Recommender System with the Flask app.
    
    Args:
        app: The Flask application instance.
        get_recommender: A function that returns the HybridRecommender instance.
    """

    @app.route('/')
    def index():
        """Home page route displaying popular manga and personalized recommendations."""
        # Fetch popular manga for display
        query = """
        SELECT manga_id, title, score, image_url, synopsis 
        FROM manga 
        WHERE popularity > 50000 
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
                
                # If recommendations exist, fetch additional details
                if not personalized_recs.empty:
                    manga_ids = personalized_recs['manga_id'].tolist()
                    placeholders = ', '.join(['%s'] * len(manga_ids))
                    query = f"""
                    SELECT manga_id, image_url, synopsis 
                    FROM manga 
                    WHERE manga_id IN ({placeholders})
                    """
                    details = execute_query(query, tuple(manga_ids))
                    
                    details_dict = {row['manga_id']: row for row in details}
                    for i, row in personalized_recs.iterrows():
                        manga_id = row['manga_id']
                        if manga_id in details_dict:
                            personalized_recs.at[i, 'image_url'] = details_dict[manga_id]['image_url']
                            personalized_recs.at[i, 'synopsis'] = details_dict[manga_id]['synopsis']
            
            except Exception as e:
                logger.error(f"Error getting personalized recommendations: {e}")
        
        return render_template(
            'index.html', 
            popular_manga=popular_manga,
            personalized_recs=personalized_recs.to_dict('records') if hasattr(personalized_recs, 'empty') and not personalized_recs.empty else personalized_recs,
            user_id=user_id,
            username=username
        )

    @app.route('/manga/<int:manga_id>')
    def manga_details(manga_id):
        """Display details of a specific manga and similar recommendations."""
        query = "SELECT * FROM manga WHERE manga_id = %s"
        manga = execute_query(query, (manga_id,), fetch_one=True)
        
        if not manga:
            return render_template('404.html', message="Manga not found"), 404
        
        similar_manga = []
        try:
            rec_system = get_recommender()
            recommendations = rec_system.get_recommendations_by_id(manga_id, top_n=6)
            
            if not recommendations.empty:
                manga_ids = recommendations['manga_id'].tolist()
                placeholders = ', '.join(['%s'] * len(manga_ids))
                query = f"""
                SELECT manga_id, title, image_url, score 
                FROM manga 
                WHERE manga_id IN ({placeholders})
                """
                similar_manga = execute_query(query, tuple(manga_ids))
        except Exception as e:
            logger.error(f"Error getting recommendations: {e}")
        
        user_rating = None
        if 'user_id' in session:
            query = "SELECT rating FROM user_ratings WHERE user_id = %s AND manga_id = %s"
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
        """Handle manga search by title or genre with pagination and sorting."""
        query_text = request.args.get('q', '')
        genre = request.args.get('genre', '')
        sort_by = request.args.get('sort', 'score')
        page = int(request.args.get('page', 1))
        per_page = 20
        
        sql_query = """
        SELECT m.manga_id, m.title, m.score, m.image_url, STRING_AGG(g.name, ', ') as genres
        FROM manga m
        LEFT JOIN manga_genres mg ON m.manga_id = mg.manga_id
        LEFT JOIN genres g ON mg.genre_id = g.genre_id
        WHERE 1=1
        """
        params = []
        
        if query_text:
            sql_query += " AND (m.title ILIKE %s OR m.title_english ILIKE %s OR m.title_japanese ILIKE %s)"
            params.extend([f'%{query_text}%'] * 3)
        
        if genre:
            sql_query += " AND g.name = %s"
            params.append(genre)
        
        sql_query += " GROUP BY m.manga_id"
        
        if sort_by == 'score':
            sql_query += " ORDER BY m.score DESC"
        elif sort_by == 'popularity':
            sql_query += " ORDER BY m.popularity DESC"
        elif sort_by == 'title':
            sql_query += " ORDER BY m.title ASC"
        
        offset = (page - 1) * per_page
        sql_query += " LIMIT %s OFFSET %s"
        params.extend([per_page, offset])
        
        results = execute_query(sql_query, tuple(params))
        
        # Get total count for pagination
        count_query = """
        SELECT COUNT(DISTINCT m.manga_id)
        FROM manga m
        LEFT JOIN manga_genres mg ON m.manga_id = mg.manga_id
        LEFT JOIN genres g ON mg.genre_id = g.genre_id
        WHERE 1=1
        """
        count_params = []
        if query_text:
            count_query += " AND (m.title ILIKE %s OR m.title_english ILIKE %s OR m.title_japanese ILIKE %s)"
            count_params.extend([f'%{query_text}%'] * 3)
        if genre:
            count_query += " AND g.name = %s"
            count_params.append(genre)
        
        total = execute_query(count_query, tuple(count_params), fetch_one=True)['count']
        total_pages = (total + per_page - 1) // per_page
        
        # Fetch available genres for filter dropdown
        genres_query = "SELECT DISTINCT name FROM genres ORDER BY name"
        genres = execute_query(genres_query)
        genres = [row['name'] for row in genres]
        
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
        """Handle user login with GET to display form and POST to process login."""
        if request.method == 'POST':
            username = request.form.get('username')
            password = request.form.get('password')
            
            if not username or not password:
                return render_template('login.html', error="Username and password are required")
            
            user = get_user(username)
            if not user or not verify_password(user['password_hash'], password):
                return render_template('login.html', error="Invalid username or password")
            
            session['user_id'] = user['user_id']
            session['username'] = user['username']
            
            next_page = request.args.get('next', 'index')
            return redirect(url_for(next_page))
        
        return render_template('login.html')

    @app.route('/register', methods=['GET', 'POST'])
    def register():
        """Handle user registration with GET to display form and POST to process registration."""
        if request.method == 'POST':
            username = request.form.get('username')
            password = request.form.get('password')
            confirm_password = request.form.get('confirm_password')
            
            if not username or not password:
                return render_template('register.html', error="Username and password are required")
            
            if password != confirm_password:
                return render_template('register.html', error="Passwords do not match")
            
            existing_user = get_user(username)
            if existing_user:
                return render_template('register.html', error="Username already exists")
            
            user_id = create_user(username, password)
            if not user_id:
                return render_template('register.html', error="Failed to create user")
            
            session['user_id'] = user_id
            session['username'] = username
            
            return redirect(url_for('index'))
        
        return render_template('register.html')

    @app.route('/logout')
    def logout():
        """Log out the user by clearing the session."""
        session.clear()
        return redirect(url_for('index'))

    @app.route('/rate', methods=['POST'])
    def rate_manga():
        """Allow logged-in users to rate a manga via POST request."""
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
            
            query = """
            INSERT INTO user_ratings (user_id, manga_id, rating, created_at)
            VALUES (%s, %s, %s, %s)
            ON CONFLICT (user_id, manga_id)
            DO UPDATE SET rating = EXCLUDED.rating, updated_at = CURRENT_TIMESTAMP
            """
            execute_query(query, (session['user_id'], manga_id, rating, datetime.now()))
            
            return jsonify({'success': True})
        
        except Exception as e:
            logger.error(f"Error rating manga: {e}")
            return jsonify({'success': False, 'message': 'Failed to save rating'}), 500

    @app.route('/profile')
    def profile():
        """Display the user's profile with their ratings and recommendations."""
        if 'user_id' not in session:
            return redirect(url_for('login', next='profile'))
        
        query = """
        SELECT ur.manga_id, ur.rating, ur.created_at, m.title, m.image_url
        FROM user_ratings ur
        JOIN manga m ON ur.manga_id = m.manga_id
        WHERE ur.user_id = %s
        ORDER BY ur.created_at DESC
        """
        ratings = execute_query(query, (session['user_id'],))
        
        personalized_recs = []
        try:
            rec_system = get_recommender()
            recs = rec_system.get_personalized_recommendations(session['user_id'], top_n=10)
            
            if not recs.empty:
                manga_ids = recs['manga_id'].tolist()
                placeholders = ', '.join(['%s'] * len(manga_ids))
                query = f"""
                SELECT manga_id, title, image_url, score 
                FROM manga 
                WHERE manga_id IN ({placeholders})
                """
                personalized_recs = execute_query(query, tuple(manga_ids))
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
        """API endpoint to get recommendations for a specific manga."""
        try:
            rec_system = get_recommender()
            recommendations = rec_system.get_recommendations_by_id(manga_id, top_n=10)
            
            if recommendations.empty:
                return jsonify([])
            
            result = recommendations.to_dict('records')
            return jsonify(result)
        
        except Exception as e:
            logger.error(f"Error getting recommendations: {e}")
            return jsonify({'error': str(e)}), 500

    @app.route('/api/user/recommendations')
    def api_user_recommendations():
        """API endpoint to get personalized recommendations for the logged-in user."""
        if 'user_id' not in session:
            return jsonify({'error': 'Not logged in'}), 401
        
        try:
            rec_system = get_recommender()
            recommendations = rec_system.get_personalized_recommendations(session['user_id'], top_n=10)
            
            if recommendations.empty:
                return jsonify([])
            
            result = recommendations.to_dict('records')
            return jsonify(result)
        
        except Exception as e:
            logger.error(f"Error getting recommendations: {e}")
            return jsonify({'error': str(e)}), 500