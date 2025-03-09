# web/routes.py
from flask import render_template, request, session, redirect, url_for, jsonify, flash
import logging
from datetime import datetime
from utils.auth import get_user, create_user, verify_password
from utils.helpers import execute_query, standardize_manga_fields
import requests
from bs4 import BeautifulSoup
from flask_login import login_required
from utils.database import DatabaseManager

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
        query_text = request.args.get('q', '')
        genre = request.args.get('genre')
        status = request.args.get('status')
        year = request.args.get('year')
        sort_by = request.args.get('sort_by', 'popularity')
        
        # Build the query with optional filters
        base_query = """
        SELECT manga_id, title, image_url, synopsis, score, popularity, published_from, genres, status 
        FROM manga 
        WHERE 1=1
        """
        
        params = []
        if query_text:
            base_query += " AND (LOWER(title) LIKE LOWER(%s) OR LOWER(title_english) LIKE LOWER(%s))"
            params.extend([f'%{query_text}%', f'%{query_text}%'])
        
        if genre:
            base_query += " AND %s = ANY(string_to_array(genres, ','))"
            params.append(genre)
        
        if status:
            base_query += " AND status = %s"
            params.append(status)
        
        if year:
            base_query += " AND EXTRACT(YEAR FROM published_from) = %s"
            params.append(int(year))
        
        # Add sorting
        base_query += f"""
        ORDER BY 
            CASE WHEN %s = 'score' THEN score
                 WHEN %s = 'latest' THEN published_from
                 ELSE popularity END DESC
        LIMIT 20
        """
        params.extend([sort_by, sort_by])
        
        results = DatabaseManager.execute_query(base_query, tuple(params))
        standardize_manga_fields(results)
        
        # Get genres for filter dropdown
        genres = DatabaseManager.execute_query("SELECT DISTINCT name FROM genres ORDER BY name")
        
        return render_template(
            'search.html', 
            results=results, 
            query=query_text,
            genres=[g['name'] for g in genres],
            selected_genre=genre,
            selected_status=status,
            selected_year=year,
            selected_sort=sort_by
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
        
        # Use consistent database access pattern
        query = """
        SELECT ur.manga_id, ur.rating, ur.created_at, m.title, m.image_url
        FROM user_ratings ur
        JOIN manga m ON ur.manga_id = m.manga_id
        WHERE ur.user_id = %s
        ORDER BY ur.created_at DESC
        """
        ratings = DatabaseManager.execute_query(query, (session['user_id'],))
        
        # Get genres for preferences section
        all_genres = DatabaseManager.execute_query("SELECT * FROM genres ORDER BY name")
        
        # Get user preferences
        user_preferences = {
            'genres': [g['genre_id'] for g in DatabaseManager.execute_query(
                "SELECT genre_id FROM user_preferences WHERE user_id = %s", 
                (session['user_id'],)
            )],
            'nsfw': False  # Default value
        }
        
        # Calculate stats for stats section
        stats = {
            'total_read': len(ratings),
            'avg_rating': DatabaseManager.execute_query(
                "SELECT AVG(rating) as avg FROM user_ratings WHERE user_id = %s", 
                (session['user_id'],), 
                fetch_one=True
            )['avg'] or 0
        }
        
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
                personalized_recs = DatabaseManager.execute_query(query, tuple(manga_ids))
        except Exception as e:
            logger.error(f"Error getting personalized recommendations: {e}")
        
        # After getting data and before rendering templates:
        standardize_manga_fields(ratings)
        standardize_manga_fields(personalized_recs)
        
        return render_template(
            'profile.html',
            ratings=ratings,
            recommendations=personalized_recs,
            username=session.get('username'),
            all_genres=all_genres,
            user_preferences=user_preferences,
            stats=stats
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
    @login_required
    def import_mal():
        mal_username = request.form.get('mal_username')
        user_id = session.get('user_id')
        
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
                        manga = DatabaseManager.execute_query(
                            "SELECT manga_id FROM manga WHERE LOWER(title) LIKE LOWER(%s) LIMIT 1",
                            (f'%{manga_title}%',),
                            fetch_one=True
                        )
                        
                        if manga:
                            # Update or create rating
                            DatabaseManager.execute_query(
                                """
                                INSERT INTO user_ratings (user_id, manga_id, rating, created_at)
                                VALUES (%s, %s, %s, %s)
                                ON CONFLICT (user_id, manga_id)
                                DO UPDATE SET rating = EXCLUDED.rating, updated_at = CURRENT_TIMESTAMP
                                """,
                                (user_id, manga['manga_id'], int(float(score)), datetime.now())
                            )
                            imported_count += 1
                
                except Exception as e:
                    logger.error(f'Error importing manga: {str(e)}')
                    continue
            
            flash(f'Successfully imported {imported_count} ratings from MAL!', 'success')
            
        except Exception as e:
            logger.error(f'MAL import error: {str(e)}')
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

    @app.route('/health/database')
    def database_health():
        try:
            # Test database connection
            query = "SELECT COUNT(*) as manga_count FROM manga"
            result = DatabaseManager.execute_query(query, fetch_one=True)
            
            # Get database statistics
            stats = {
                'manga_count': result['manga_count'],
                'user_count': DatabaseManager.execute_query(
                    "SELECT COUNT(*) as count FROM users", fetch_one=True
                )['count'],
                'rating_count': DatabaseManager.execute_query(
                    "SELECT COUNT(*) as count FROM user_ratings", fetch_one=True
                )['count'],
                'avg_rating': DatabaseManager.execute_query(
                    "SELECT AVG(rating) as avg FROM user_ratings", fetch_one=True
                )['avg']
            }
            
            return jsonify({
                'status': 'healthy',
                'statistics': stats
            })
        except Exception as e:
            logger.error(f"Database health check failed: {e}")
            return jsonify({
                'status': 'unhealthy',
                'error': str(e)
            }), 500

    @app.route('/update-preferences', methods=['POST'])
    @login_required
    def update_preferences():
        """Update user genre preferences and settings."""
        user_id = session.get('user_id')
        if not user_id:
            return jsonify({'success': False, 'message': 'Not logged in'}), 401
        
        try:
            # Get form data
            favorite_genres = request.form.getlist('favorite_genres')
            nsfw = 'nsfw' in request.form
            
            # Clear existing preferences
            DatabaseManager.execute_query(
                "DELETE FROM user_preferences WHERE user_id = %s",
                (user_id,)
            )
            
            # Add new preferences
            if favorite_genres:
                params_list = [(user_id, int(genre_id), 1.0) for genre_id in favorite_genres]
                DatabaseManager.execute_batch(
                    "INSERT INTO user_preferences (user_id, genre_id, weight) VALUES (%s, %s, %s)",
                    params_list
                )
            
            # Update user settings
            DatabaseManager.execute_query(
                "UPDATE users SET show_nsfw = %s WHERE user_id = %s",
                (nsfw, user_id)
            )
            
            return jsonify({'success': True, 'message': 'Preferences updated'})
        except Exception as e:
            logger.error(f"Error updating preferences: {e}")
            return jsonify({'success': False, 'message': 'Failed to update preferences'}), 500

    @app.route('/api/user-genre-stats')
    @login_required
    def get_user_genre_stats():
        """Get statistics about user's manga genres for the chart."""
        user_id = session.get('user_id')
        
        query = """
        SELECT g.name, COUNT(*) as count
        FROM user_ratings ur
        JOIN manga_genres mg ON ur.manga_id = mg.manga_id
        JOIN genres g ON mg.genre_id = g.genre_id
        WHERE ur.user_id = %s
        GROUP BY g.name
        ORDER BY count DESC
        LIMIT 7
        """
        
        results = DatabaseManager.execute_query(query, (user_id,))
        
        return jsonify({
            'labels': [row['name'] for row in results],
            'values': [row['count'] for row in results]
        })

    @app.route('/api/manga/<int:manga_id>/details_with_recommendations')
    def manga_details_with_recommendations(manga_id):
        """
        API endpoint to get comprehensive manga details along with similar recommendations.
        Returns both the manga's information and a list of similar manga recommendations.
        """
        try:
            # Get manga details
            query = """
            SELECT m.*, 
                STRING_AGG(DISTINCT g.name, ', ') as genre_list,
                STRING_AGG(DISTINCT a.name, ', ') as author_list
            FROM manga m
            LEFT JOIN manga_genres mg ON m.manga_id = mg.manga_id
            LEFT JOIN genres g ON mg.genre_id = g.genre_id
            LEFT JOIN manga_authors ma ON m.manga_id = ma.manga_id
            LEFT JOIN authors a ON ma.author_id = a.author_id
            WHERE m.manga_id = %s
            GROUP BY m.manga_id
            """
            manga = execute_query(query, (manga_id,), fetch_one=True)
            
            if not manga:
                return jsonify({'error': 'Manga not found'}), 404
            
            # Standardize fields
            standardize_manga_fields(manga)
            
            # Get recommendations
            similar_manga = []
            rec_system = get_recommender()
            recommendations = rec_system.get_recommendations_by_id(manga_id, top_n=10)
            
            if not recommendations.empty:
                manga_ids = recommendations['manga_id'].tolist()
                placeholders = ', '.join(['%s'] * len(manga_ids))
                query = f"""
                SELECT m.manga_id, m.title, m.image_url, m.score, m.popularity, 
                       m.status, m.published_from, m.published_to, m.synopsis,
                       STRING_AGG(DISTINCT g.name, ', ') as genre_list
                FROM manga m
                LEFT JOIN manga_genres mg ON m.manga_id = mg.manga_id
                LEFT JOIN genres g ON mg.genre_id = g.genre_id
                WHERE m.manga_id IN ({placeholders})
                GROUP BY m.manga_id
                """
                similar_manga = execute_query(query, tuple(manga_ids))
                standardize_manga_fields(similar_manga)
                
                # Add similarity scores from recommendation system
                similarity_dict = {row['manga_id']: row['hybrid_score'] if 'hybrid_score' in row else row['similarity'] 
                                  for _, row in recommendations.iterrows()}
                
                for i, rec in enumerate(similar_manga):
                    rec['similarity_score'] = similarity_dict.get(rec['manga_id'], 0)
            
            # Get user rating if logged in
            user_rating = None
            if 'user_id' in session:
                query = "SELECT rating FROM user_ratings WHERE user_id = %s AND manga_id = %s"
                result = execute_query(query, (session['user_id'], manga_id), fetch_one=True)
                user_rating = result['rating'] if result else None
            
            # Create response object
            response = {
                'manga': manga,
                'recommendations': similar_manga,
                'user_rating': user_rating
            }
            
            return jsonify(response)
            
        except Exception as e:
            logger.error(f"Error getting manga details with recommendations: {e}")
            return jsonify({'error': str(e)}), 500