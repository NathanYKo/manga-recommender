import os
import sys

# Set the DATABASE_URL explicitly if not already set
# This will be overridden by Render's environment variable
if 'DATABASE_URL' not in os.environ:
    os.environ['DATABASE_URL'] = 'postgresql://postgres:postgres@localhost:5432/manga_recommender'

# Import the Flask app
from web.app import app

# This is necessary for Vercel and Render
if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    app.run(host="0.0.0.0", port=port) 