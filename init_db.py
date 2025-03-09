#!/usr/bin/env python
"""
Database initialization script for the Manga Recommender application.
This script will create the necessary tables and load initial data.
"""

import os
import sys
import logging
import psycopg2
from psycopg2.extras import RealDictCursor

# Set up logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger('manga_recommender.init_db')

def get_db_connection():
    """Connect to the PostgreSQL database"""
    db_url = os.environ.get('DATABASE_URL')
    if not db_url:
        logger.error("DATABASE_URL environment variable not set")
        sys.exit(1)
        
    try:
        # Handle potential Heroku/Render style postgres:// URLs
        if db_url.startswith('postgres://'):
            db_url = db_url.replace('postgres://', 'postgresql://', 1)
            
        conn = psycopg2.connect(db_url, cursor_factory=RealDictCursor)
        logger.info("Connected to database using DATABASE_URL")
        return conn
    except Exception as e:
        logger.error(f"Error connecting to database: {e}")
        sys.exit(1)

def initialize_database():
    """Initialize the database with required tables and initial data"""
    conn = get_db_connection()
    cursor = conn.cursor()
    
    try:
        # Create tables
        logger.info("Creating tables...")
        
        # Check if manga table exists
        cursor.execute("""
            SELECT EXISTS (
               SELECT FROM information_schema.tables 
               WHERE table_name = 'manga'
            );
        """)
        table_exists = cursor.fetchone()['exists']
        
        if not table_exists:
            # Read the SQL file and execute
            logger.info("Reading SQL schema from init_schema.sql...")
            try:
                with open('init_schema.sql', 'r') as f:
                    sql_script = f.read()
                    
                # Execute each statement separately for better error handling
                logger.info("Executing SQL script...")
                for statement in sql_script.split(';'):
                    if statement.strip():
                        try:
                            cursor.execute(statement)
                            conn.commit()
                        except Exception as stmt_error:
                            conn.rollback()
                            logger.error(f"Error executing statement: {statement[:100]}...")
                            logger.error(f"Error details: {stmt_error}")
                            # Continue with next statement
                
                logger.info("Database schema initialized successfully!")
                
                # Check if manga data was inserted
                cursor.execute("SELECT COUNT(*) FROM manga")
                manga_count = cursor.fetchone()['count']
                logger.info(f"Manga table has {manga_count} entries")
                
            except Exception as script_error:
                logger.error(f"Error reading or processing SQL file: {script_error}")
                return False
        else:
            logger.info("Tables already exist, skipping initialization")
            
        return True
            
    except Exception as e:
        conn.rollback()
        logger.error(f"Error initializing database: {e}")
        # Don't exit the program, just return failure status
        return False
    finally:
        cursor.close()
        conn.close()

if __name__ == "__main__":
    logger.info("Starting database initialization...")
    initialize_database() 