#!/usr/bin/env python3
"""
Script to fetch more manga data from Jikan API and add it to the database.
This script is an extension of the ETL process, focused on gathering more manga entries.
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
        logging.FileHandler('manga_import.log')
    ]
)
logger = logging.getLogger('manga_import')

# Load environment variables
load_dotenv()

# Import ETL components
try:
    from etl.extract import MangaExtractor
    from etl.transform import MangaTransformer
    from etl.load import MangaLoader
except ImportError:
    logger.error("Failed to import ETL components. Make sure you run this script from the project root directory.")
    sys.exit(1)

def get_current_manga_count():
    """Get the current number of manga in the database"""
    from utils.database import DatabaseManager
    try:
        DatabaseManager.initialize()
        with DatabaseManager.get_connection() as conn:
            with conn.cursor() as cursor:
                cursor.execute("SELECT COUNT(*) FROM manga")
                count = cursor.fetchone()[0]
                logger.info(f"Current manga count in database: {count}")
                return count
    except Exception as e:
        logger.error(f"Failed to get manga count: {e}")
        return None

def import_more_manga(page_limit=None, start_page=1, max_manga=1000):
    """
    Fetch more manga from the Jikan API and add them to the database.
    
    Args:
        page_limit: Maximum number of pages to fetch (25 manga per page)
        start_page: Page to start fetching from
        max_manga: Maximum number of manga to add
    """
    start_time = datetime.now()
    logger.info(f"Starting manga import process at {start_time}")
    
    # Get current manga count
    current_count = get_current_manga_count()
    if current_count is None:
        logger.error("Could not determine current manga count. Aborting.")
        return
    
    if current_count >= max_manga:
        logger.info(f"Database already has {current_count} manga, which is at or above the target of {max_manga}. No import needed.")
        return
    
    # Calculate how many more manga we need
    manga_to_add = max_manga - current_count
    pages_needed = (manga_to_add + 24) // 25  # 25 manga per page, rounding up
    
    if page_limit is None:
        page_limit = pages_needed
    else:
        page_limit = min(page_limit, pages_needed)
    
    logger.info(f"Need to add {manga_to_add} more manga. Will fetch up to {page_limit} pages starting from page {start_page}.")
    
    # Extract
    logger.info("Starting extraction process...")
    extractor = MangaExtractor()
    
    # Modify the extract_manga_list method to accept start_page parameter
    original_extract_manga_list = extractor.extract_manga_list
    
    async def modified_extract_manga_list(page_limit=None):
        """Modified extract_manga_list that starts from a specific page"""
        manga_list_url = f"{extractor.base_url}/manga"
        page = start_page
        total_pages = float('inf')
        manga_list = []
        
        import aiohttp
        import asyncio
        from tqdm import tqdm
        
        async with aiohttp.ClientSession() as session:
            with tqdm(total=page_limit or total_pages, desc="Extracting manga list") as pbar:
                while page <= (page_limit and page_limit + start_page - 1 or total_pages):
                    params = {'page': page, 'limit': 25, 'order_by': 'popularity', 'sort': 'asc'}
                    data = await extractor.fetch_page(session, manga_list_url, params)
                    
                    if data is None:
                        break
                    
                    if 'pagination' in data and 'last_visible_page' in data['pagination']:
                        total_pages = data['pagination']['last_visible_page']
                        pbar.total = min(page_limit or total_pages, total_pages - start_page + 1)
                        
                    if 'data' in data:
                        manga_list.extend(data['data'])
                        
                        # Save checkpoint every 5 pages
                        if page % 5 == 0:
                            checkpoint_file = os.path.join(extractor.raw_data_dir, f"manga_list_checkpoint_{page}.json")
                            from utils.helpers import save_json
                            save_json(manga_list, checkpoint_file)
                    
                    page += 1
                    pbar.update(1)
                    
                    # Respect rate limit
                    await asyncio.sleep(1 / extractor.rate_limit)
        
        # Save complete manga list
        from utils.helpers import save_json
        save_json(manga_list, os.path.join(extractor.raw_data_dir, "manga_list.json"))
        logger.info(f"Extracted {len(manga_list)} manga entries")
        return manga_list
    
    # Replace the method with our modified version
    import types
    extractor.extract_manga_list = types.MethodType(modified_extract_manga_list, extractor)
    
    # Run the modified extraction
    import asyncio
    loop = asyncio.get_event_loop()
    manga_list = loop.run_until_complete(extractor.extract_manga_list(page_limit))
    
    # Extract IDs for detailed information
    manga_ids = [manga['mal_id'] for manga in manga_list]
    loop.run_until_complete(extractor.extract_manga_details(manga_ids))
    
    # Transform
    logger.info("Starting transformation process...")
    transformer = MangaTransformer()
    transformation_result = transformer.run_transformation()
    logger.info(f"Transformation completed: {transformation_result}")
    
    # Load
    logger.info("Starting loading process...")
    loader = MangaLoader()
    loading_result = loader.run_loading()
    logger.info(f"Loading completed: {loading_result}")
    
    # Get final manga count
    final_count = get_current_manga_count()
    manga_added = final_count - current_count if final_count is not None else "unknown"
    
    end_time = datetime.now()
    duration = end_time - start_time
    
    logger.info(f"Manga import process completed at {end_time}")
    logger.info(f"Duration: {duration}")
    logger.info(f"Added {manga_added} new manga entries")
    logger.info(f"Total manga count: {final_count}")
    
    return {
        'initial_count': current_count,
        'final_count': final_count,
        'manga_added': manga_added,
        'duration': str(duration)
    }

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Import more manga from Jikan API to the database')
    parser.add_argument('--pages', type=int, help='Limit the number of pages to extract', default=None)
    parser.add_argument('--start', type=int, help='Page to start fetching from', default=1)
    parser.add_argument('--max', type=int, help='Maximum total manga to have in database', default=1000)
    args = parser.parse_args()
    
    result = import_more_manga(page_limit=args.pages, start_page=args.start, max_manga=args.max)
    print(f"Import process completed: {result}") 