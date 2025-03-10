#!/usr/bin/env python3
"""
Script to periodically update manga data in the database.
This script can be run as a scheduled task (e.g., weekly) to fetch latest
manga information and keep your database current.
"""

import os
import sys
import logging
import argparse
from dotenv import load_dotenv
from datetime import datetime

# Set up logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        logging.StreamHandler(),
        logging.FileHandler('database_update.log')
    ]
)
logger = logging.getLogger('database_update')

# Load environment variables
load_dotenv()

def update_existing_manga(limit=100):
    """
    Update information for existing manga in the database.
    Fetches fresh data from the API for manga that might have outdated information.
    
    Args:
        limit: Maximum number of manga to update in one run (default: 100)
    """
    from utils.database import DatabaseManager
    from etl.extract import MangaExtractor
    from etl.transform import MangaTransformer
    from etl.load import MangaLoader
    import pandas as pd
    
    try:
        # Initialize database connection
        DatabaseManager.initialize()
        
        # Get oldest updated manga
        query = """
        SELECT manga_id, title, updated_at
        FROM manga
        ORDER BY updated_at ASC NULLS FIRST
        LIMIT %s
        """
        
        with DatabaseManager.get_connection() as conn:
            with conn.cursor() as cursor:
                cursor.execute(query, (limit,))
                manga_to_update = cursor.fetchall()
                
        if not manga_to_update:
            logger.info("No manga found to update")
            return
            
        # Convert to DataFrame for easier processing
        manga_df = pd.DataFrame(manga_to_update, columns=['manga_id', 'title', 'updated_at'])
        logger.info(f"Found {len(manga_df)} manga to update")
        
        # Extract manga IDs to update
        manga_ids = manga_df['manga_id'].tolist()
        
        # Initialize extraction
        extractor = MangaExtractor()
        
        # Extract updated details
        import asyncio
        loop = asyncio.get_event_loop()
        loop.run_until_complete(extractor.extract_manga_details(manga_ids))
        
        # Transform the data
        transformer = MangaTransformer()
        transformer.run_transformation()
        
        # Load data back to database
        loader = MangaLoader()
        loader.load_manga()
        
        # Log results
        logger.info(f"Successfully updated {len(manga_ids)} manga entries")
        
        # Update last_update.txt
        with open('last_database_update.txt', 'w') as f:
            f.write(f"Last database update: {datetime.now()}")
            
        return True
    
    except Exception as e:
        logger.error(f"Error updating manga: {e}")
        return False

def fetch_new_manga(limit=25):
    """
    Fetch new manga that aren't in the database yet.
    
    Args:
        limit: Maximum number of new manga to add (default: 25)
    """
    from fetch_more_manga import import_more_manga
    
    try:
        # Use the existing import function with a small limit
        result = import_more_manga(page_limit=1, max_manga=limit)
        logger.info(f"Fetched new manga: {result}")
        return True
    except Exception as e:
        logger.error(f"Error fetching new manga: {e}")
        return False

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Update manga data in the database')
    parser.add_argument('--update-existing', type=int, default=100, 
                        help='Number of existing manga to update')
    parser.add_argument('--fetch-new', type=int, default=25,
                        help='Number of new manga to fetch')
    args = parser.parse_args()
    
    logger.info("Starting database update process")
    update_existing_manga(args.update_existing)
    fetch_new_manga(args.fetch_new)
    logger.info("Database update process completed") 