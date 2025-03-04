# utils/helpers.py
import os
import json
import logging
from datetime import datetime
from sqlalchemy import create_engine, text
from utils.config import config
import psycopg2
from psycopg2.extras import RealDictCursor
import sqlalchemy

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        logging.StreamHandler()
    ]
)

logger = logging.getLogger('manga_recommender')

# Database connection pool for serverless environment
_engine = None

def ensure_directory(directory):
    """Create directory if it doesn't exist"""
    if not os.path.exists(directory):
        os.makedirs(directory)
        logger.info(f"Created directory: {directory}")

def save_json(data, filepath):
    """Save data as JSON file"""
    ensure_directory(os.path.dirname(filepath))
    with open(filepath, 'w', encoding='utf-8') as f:
        json.dump(data, f, ensure_ascii=False, indent=4)
    logger.info(f"Saved data to {filepath}")

def load_json(filepath):
    """Load data from JSON file"""
    with open(filepath, 'r', encoding='utf-8') as f:
        return json.load(f)

def get_db_engine():
    """Get or create SQLAlchemy engine with connection pooling"""
    global _engine
    if _engine is None:
        database_url = os.environ.get('DATABASE_URL')
        
        # Neon requires SSL
        if 'neon.tech' in database_url:
            _engine = create_engine(
                database_url,
                pool_pre_ping=True,
                pool_recycle=3600,
                pool_size=5,
                max_overflow=10,
                connect_args={"sslmode": "require"}
            )
        else:
            _engine = create_engine(
                database_url,
                pool_pre_ping=True,
                pool_recycle=3600,
                pool_size=5,
                max_overflow=10
            )
    return _engine

def execute_query(query, params=None, fetch_one=False, commit=False):
    """Execute a database query with proper connection handling"""
    engine = get_db_engine()
    
    with engine.connect() as connection:
        if commit:
            # For INSERT/UPDATE/DELETE operations
            with connection.begin():
                result = connection.execute(sqlalchemy.text(query), params or {})
                return result
        else:
            # For SELECT operations
            result = connection.execute(sqlalchemy.text(query), params or {})
            if fetch_one:
                return dict(result.fetchone()) if result.rowcount > 0 else None
            return [dict(row) for row in result.fetchall()]