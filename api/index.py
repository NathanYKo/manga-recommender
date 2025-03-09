import os
import sys
import logging

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger('manga_recommender.api')

# Set the DATABASE_URL explicitly if not already set
# This will be overridden by Render's environment variable
if 'DATABASE_URL' not in os.environ:
    os.environ['DATABASE_URL'] = 'postgresql://postgres:postgres@localhost:5432/manga_recommender'

# Import the Flask app
try:
    from web.app import app
    
    # Handle database initialization errors gracefully
    @app.route('/db-error')
    def db_error():
        return """
        <html>
            <head><title>Database Error</title></head>
            <body>
                <h1>Database Initialization Error</h1>
                <p>There was a problem initializing the database. Please check the logs for more information.</p>
                <p>You can still explore the application, but some features may not work correctly.</p>
                <a href="/">Go to Homepage</a>
            </body>
        </html>
        """, 500
    
except ImportError as e:
    logger.error(f"Error importing Flask app: {e}")
    sys.exit(1)

# This is necessary for Vercel and Render
if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    app.run(host="0.0.0.0", port=port) 