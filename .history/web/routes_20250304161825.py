# web/routes.py
from flask import render_template, request, session, redirect, url_for, jsonify, flash
import logging
from datetime import datetime
from utils.auth import get_user, create_user, verify_password
from utils.helpers import execute_query, standardize_manga_fields
import requests
from bs4 import BeautifulSoup
from flask_login import login_required

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
        
        # After getting data and before rendering templates:
        standardize_manga_fields(popular_manga)
        standardize_manga_fields(personalized_recs)
        
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
        
        # After getting data and before rendering templates:
        standardize_manga_fields(manga)
        standardize_manga_fields(similar_manga)
        
        return render_template(
            'manga_details.html',
            manga=manga,
            similar_manga=similar_manga,
            user_rating=user_rating,
            user_id=session.get('user_id'),
            username=session.get('username')
        )

    @app.route('/search', methods=['GET', 'POST'])
    def search():
        """Search for manga and show recommendations for similar titles."""
        # Add these parameters
        genre = request.args.get('genre')
        status = request.args.get('status')
        year = request.args.get('year')
        sort_by = request.args.get('sort_by', 'popularity')
        
        query = """
        SELECT manga_id, title, image_url, synopsis, score, popularity, published_at, genres, status 
        FROM manga 
        WHERE (LOWER(title) LIKE LOWER(%s) OR LOWER(alternative_titles) LIKE LOWER(%s))
        AND (%s IS NULL OR genres LIKE %s)
        AND (%s IS NULL OR status = %s)
        AND (%s IS NULL OR EXTRACT(YEAR FROM published_at) = %s)
        ORDER BY 
            CASE WHEN %s = 'score' THEN score
                 WHEN %s = 'latest' THEN published_at
                 ELSE popularity END DESC
        LIMIT 20
        """
        search_term = request.args.get('q', '') or request.form.get('search', '')
        results = []
        similar_manga = []
        error = None
        is_htmx_request = request.headers.get('HX-Request') == 'true'
        
        if search_term:
            try:
                # Search for manga matching the term
                search_param = f'%{search_term}%'
                results = execute_query(query, (search_param, search_param, genre, genre, status, status, year, year, sort_by, sort_by))
                
                # If we have results, get recommendations for the first match
                if results and len(results) > 0:
                    try:
                        # Get similar manga using the recommender system
                        rec_system = get_recommender()
                        manga_id = results[0]['manga_id']
                        
                        # Get similar manga
                        similar = rec_system.get_similar_manga(manga_id, top_n=6)
                        
                        if not similar.empty:
                            # Get additional details for the similar manga
                            manga_ids = similar['manga_id'].tolist()
                            placeholders = ', '.join(['%s'] * len(manga_ids))
                            query = f"""
                            SELECT manga_id, title, image_url, synopsis, score, published_at
                            FROM manga
                            WHERE manga_id IN ({placeholders})
                            """
                            similar_manga = execute_query(query, tuple(manga_ids))
                    except Exception as e:
                        logger.error(f"Error getting similar manga: {e}")
                        error = "We couldn't find similar titles at this time."
            except Exception as e:
                logger.error(f"Error searching manga: {e}")
                error = "An error occurred while searching. Please try again."
        
        # If this is an HTMX request, render just the results section
        if is_htmx_request:
            return render_template(
                'partials/search_results.html',
                search_term=search_term,
                results=results,
                similar_manga=similar_manga,
                error=error
            )
        
        # Otherwise render the full page
        return render_template(
            'search.html',
            search_term=search_term,
            results=results,
            similar_manga=similar_manga,
            error=error
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
        
        # After getting data and before rendering templates:
        standardize_manga_fields(ratings)
        standardize_manga_fields(personalized_recs)
        
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

    @app.route('/import-mal', methods=['POST'])
    def import_mal():
        mal_username = request.form.get('mal_username')
        if not mal_username:
            flash('Please provide your MAL username', 'error')
            return redirect(url_for('profile'))
        
        try:
            # Fetch user's manga list from MAL
            response = requests.get(f'https://myanimelist.net/mangalist/{mal_username}')
            if response.status_code != 200:
                flash('Could not find MAL profile. Please check the username.', 'error')
                return redirect(url_for('profile'))
            
            soup = BeautifulSoup(response.text, 'html.parser')
            manga_items = soup.select('#list_surround table.list-table tbody tr')
            
            imported_count = 0
            for item in manga_items:
                try:
                    manga_title = item.select_one('.manga_title').text
                    score = item.select_one('.score').text
                    
                    if score and score != '-':
                        # Find manga in our database
                        manga = Manga.query.filter(
                            Manga.title.ilike(f'%{manga_title}%')
                        ).first()
                        
                        if manga:
                            # Update or create rating
                            rating = Rating.query.filter_by(
                                user_id=current_user.id,
                                manga_id=manga.id
                            ).first() or Rating(
                                user_id=current_user.id,
                                manga_id=manga.id
                            )
                            
                            rating.score = int(float(score))
                            db.session.add(rating)
                            imported_count += 1
                
                except Exception as e:
                    app.logger.error(f'Error importing manga: {str(e)}')
                    continue
            
            db.session.commit()
            flash(f'Successfully imported {imported_count} ratings from MAL!', 'success')
            
        except Exception as e:
            app.logger.error(f'MAL import error: {str(e)}')
            flash('Error importing from MAL. Please try again later.', 'error')
        
        return redirect(url_for('profile'))

    @app.route('/reading-list/<status>', methods=['GET'])
    @login_required
    def reading_list(status):
        query = """
        SELECT m.*, rl.status, rl.updated_at
        FROM reading_list rl
        JOIN manga m ON rl.manga_id = m.manga_id
        WHERE rl.user_id = %s AND rl.status = %s
        ORDER BY rl.updated_at DESC
        """
        manga_list = execute_query(query, (session['user_id'], status))
        return render_template('reading_list.html', manga_list=manga_list, current_status=status)