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

def execute_query(query, params=None):
    """Execute SQL query and return results"""
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute(query, params)
        
        # If this is a SELECT query, return results
        if query.strip().upper().startswith('SELECT'):
            result = cursor.fetchall()
            cursor.close()
            conn.close()
            return result
        
        # Otherwise commit the transaction
        conn.commit()
        cursor.close()
        conn.close()
        return True
    except Exception as e:
        logger.error(f"Database error: {e}")
        raise

def get_db_connection():
    """Get database connection with environment variable support"""
    # First try environment variable (for production)
    database_url = os.environ.get('DATABASE_URL')
    
    if database_url:
        # Handle potential Heroku/Render style postgres:// URLs
        if database_url.startswith('postgres://'):
            database_url = database_url.replace('postgres://', 'postgresql://', 1)
        
        try:
            # Log the database_url without password for debugging (if present)
            safe_url = database_url
            if '@' in database_url and ':' in database_url.split('@')[0]:
                auth, rest = database_url.split('@', 1)
                if ':' in auth:
                    user, pwd = auth.split(':', 1)
                    safe_url = f"{user}:****@{rest}"
            logger.info(f"Connecting to database using URL: {safe_url}")
            
            conn = psycopg2.connect(database_url, cursor_factory=RealDictCursor)
            logger.info("Connected to database using DATABASE_URL")
            return conn
        except Exception as e:
            logger.error(f"Error connecting with DATABASE_URL: {e}")
            # Fall back to config as a last resort
    
    # Fall back to config values
    try:
        db_config = config.get_db_config()
        logger.info(f"Connecting to database using config values: host={db_config.get('host')}, user={db_config.get('user')}, database={db_config.get('database')}")
        
        # Only include non-empty parameters
        connect_params = {}
        if 'host' in db_config and db_config['host']:
            connect_params['host'] = db_config['host']
        if 'port' in db_config and db_config['port']:
            connect_params['port'] = db_config['port']
        if 'database' in db_config and db_config['database']:
            connect_params['dbname'] = db_config['database']
        if 'user' in db_config and db_config['user']:
            connect_params['user'] = db_config['user']
        if 'password' in db_config and db_config['password']:
            connect_params['password'] = db_config['password']
        
        # Always use RealDictCursor
        connect_params['cursor_factory'] = RealDictCursor
        
        logger.info(f"Connection parameters: {str({k: '****' if k == 'password' else v for k, v in connect_params.items()})}")
        conn = psycopg2.connect(**connect_params)
        logger.info("Connected to database using config values")
        return conn
    except Exception as e:
        logger.error(f"Error connecting with config values: {e}")
        raise

def standardize_manga_fields(manga_data):
    """Standardize field names in manga data (list or dict)"""
    if isinstance(manga_data, list):
        for item in manga_data:
            standardize_manga_fields(item)
    elif isinstance(manga_data, dict):
        # Convert img_url to image_url
        if 'img_url' in manga_data and 'image_url' not in manga_data:
            manga_data['image_url'] = manga_data['img_url']
        
        # Handle genre_list from our aggregation query
        if 'genre_list' in manga_data and 'genres' not in manga_data:
            manga_data['genres'] = manga_data['genre_list']
            
        # Add default fields if not present
        if 'type' not in manga_data:
            manga_data['type'] = 'Manga'
            
        if 'status' not in manga_data:
            manga_data['status'] = manga_data.get('publishing', 'Unknown')
            
        if 'published' not in manga_data:
            # Try to construct published date range if available
            if 'published_from' in manga_data and manga_data['published_from']:
                published_str = str(manga_data['published_from'])
                if 'published_to' in manga_data and manga_data['published_to']:
                    published_str += " to " + str(manga_data['published_to'])
                manga_data['published'] = published_str
            else:
                manga_data['published'] = 'Unknown'
                
        if 'authors' not in manga_data:
            manga_data['authors'] = 'Unknown'
    
    return manga_data