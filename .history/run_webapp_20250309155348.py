#!/usr/bin/env python
"""
Run script for the Manga Recommender web application.
This sets up the environment and starts the Flask development server.
"""

import os
import sys
from web.app import app

# Set the DATABASE_URL explicitly if not already set
if 'DATABASE_URL' not in os.environ:
    os.environ['DATABASE_URL'] = 'postgresql://nathanko@localhost:5432/manga_recommender'

# Set Flask environment variables
os.environ['FLASK_ENV'] = 'development'
os.environ['FLASK_DEBUG'] = '1'

if __name__ == "__main__":
    # Use port 5001 instead of 5000 to avoid conflicts on macOS
    port = int(os.environ.get('PORT', 5001))
    app.run(host='0.0.0.0', port=port, debug=True) 