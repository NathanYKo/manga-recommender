# web/app.py
from flask import Flask, render_template, request, session, redirect, url_for, jsonify
import os
import logging
import secrets
from datetime import datetime

# Set the DATABASE_URL explicitly if not already set
if 'DATABASE_URL' not in os.environ:
    os.environ['DATABASE_URL'] = 'postgresql://nathanko@localhost:5432/manga_recommender'

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
app = Flask(__name__, 
            static_folder=os.path.join(os.path.dirname(os.path.dirname(__file__)), 'static'),
            template_folder=os.path.join(os.path.dirname(os.path.dirname(__file__)), 'templates'))
app.secret_key = os.environ.get('SECRET_KEY', secrets.token_hex(16))

# Add built-in functions to the template environment
app.jinja_env.globals['min'] = min
app.jinja_env.globals['max'] = max

# Add custom template filters
@app.template_filter('truncate_text')
def truncate_text(text, length=100):
    """Truncate text to a specified length and add ellipsis if needed."""
    if not text:
        return ""
    if len(text) <= length:
        return text
    return text[:length].rsplit(' ', 1)[0] + '...'

# Initialize recommender system (lazy loading)
recommender = None

def get_recommender():
    """Get or initialize the recommender system"""
    global recommender
    if recommender is None:
        try:
            logger.info("Initializing recommender system...")
            recommender = HybridRecommender(
                content_weight=0.7,
                collab_weight=0.3
            )
            recommender.fit()
            logger.info("Recommender system initialized successfully")
        except Exception as e:
            logger.error(f"Error initializing recommender: {e}")
            recommender = None  # Reset to None so we can try again next time
    return recommender

# Import and register routes
from web.routes import register_routes
register_routes(app, get_recommender)

@app.errorhandler(404)
def page_not_found(e):
    """Handle 404 errors"""
    return render_template('404.html'), 404

@app.errorhandler(500)
def server_error(e):
    """Handle 500 errors"""
    logger.error(f"Server error: {e}")
    return render_template('500.html'), 500