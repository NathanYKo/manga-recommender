# utils/helpers.py
import os
import json
import logging
from datetime import datetime
from sqlalchemy import create_engine, text
from utils.config import config

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        logging.StreamHandler(),
        logging.FileHandler('manga_recommender.log')
    ]
)

logger = logging.getLogger('manga_recommender')

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
    """Create and return a SQLAlchemy engine"""
    db_config = config.get_db_config()
    connection_string = f"postgresql://{db_config['user']}:{db_config['password']}@{db_config['host']}:{db_config['port']}/{db_config['database']}"
    return create_engine(connection_string)

def execute_query(query, params=None):
    """Execute a SQL query"""
    engine = get_db_engine()
    with engine.connect() as connection:
        if params:
            result = connection.execute(text(query), params)
        else:
            result = connection.execute(text(query))
        connection.commit()
        return result