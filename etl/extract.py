import os
import time
import json
import aiohttp
import asyncio
from tqdm import tqdm
import logging
from utils.config import config
from utils.helpers import ensure_directory, save_json

logger = logging.getLogger('manga_recommender.extract')

class MangaExtractor:
    def __init__(self):
        api_config = config.get_api_config()
        self.base_url = api_config['base_url']
        self.rate_limit = int(api_config['rate_limit'])
        self.max_retries = int(api_config['max_retries'])
        self.raw_data_dir = os.path.join('data', 'raw')
        ensure_directory(self.raw_data_dir)
        
    async def fetch_page(self, session, url, params=None, retry_count=0):
        """Fetch a single page of data from the API"""
        try:
            async with session.get(url, params=params) as response:
                if response.status == 429:  # Rate limit exceeded
                    wait_time = int(response.headers.get('Retry-After', 5))
                    logger.warning(f"Rate limit exceeded. Waiting for {wait_time} seconds.")
                    await asyncio.sleep(wait_time)
                    return await self.fetch_page(session, url, params, retry_count)
                
                if response.status != 200:
                    if retry_count < self.max_retries:
                        wait_time = 2 ** retry_count  # Exponential backoff
                        logger.warning(f"Request failed with status {response.status}. Retrying in {wait_time} seconds.")
                        await asyncio.sleep(wait_time)
                        return await self.fetch_page(session, url, params, retry_count + 1)
                    else:
                        logger.error(f"Request failed with status {response.status} after {self.max_retries} retries.")
                        return None
                
                return await response.json()
        except Exception as e:
            if retry_count < self.max_retries:
                wait_time = 2 ** retry_count
                logger.warning(f"Request failed with error: {str(e)}. Retrying in {wait_time} seconds.")
                await asyncio.sleep(wait_time)
                return await self.fetch_page(session, url, params, retry_count + 1)
            else:
                logger.error(f"Request failed with error: {str(e)} after {self.max_retries} retries.")
                return None
    
    async def extract_manga_list(self, page_limit=None):
        """Extract manga list from API"""
        manga_list_url = f"{self.base_url}/manga"
        page = 1
        total_pages = float('inf')
        manga_list = []
        
        async with aiohttp.ClientSession() as session:
            with tqdm(total=page_limit or total_pages, desc="Extracting manga list") as pbar:
                while page <= (page_limit or total_pages):
                    params = {'page': page, 'limit': 25}  # Jikan's max limit is 25
                    data = await self.fetch_page(session, manga_list_url, params)
                    
                    if data is None:
                        break
                    
                    if 'pagination' in data and 'last_visible_page' in data['pagination']:
                        total_pages = data['pagination']['last_visible_page']
                        pbar.total = page_limit or total_pages
                        
                    if 'data' in data:
                        manga_list.extend(data['data'])
                        
                        # Save checkpoint every 10 pages
                        if page % 10 == 0:
                            checkpoint_file = os.path.join(self.raw_data_dir, f"manga_list_checkpoint_{page}.json")
                            save_json(manga_list, checkpoint_file)
                    
                    page += 1
                    pbar.update(1)
                    
                    # Respect rate limit for list extraction
                    await asyncio.sleep(1 / self.rate_limit)
        
        # Save complete manga list
        save_json(manga_list, os.path.join(self.raw_data_dir, "manga_list.json"))
        logger.info(f"Extracted {len(manga_list)} manga entries")
        return manga_list
    
    async def extract_manga_details(self, manga_ids, batch_size=60):
        """Extract detailed information for specific manga IDs in batches with checkpointing"""
        # Get existing manga detail files with numeric IDs
        existing_files = [
            f for f in os.listdir(self.raw_data_dir)
            if f.startswith('manga_') and f.endswith('.json')
            and f[len('manga_'):-len('.json')].isdigit()
        ]
        existing_manga_ids = {
            int(f[len('manga_'):-len('.json')]) for f in existing_files
        }
        
        # Filter out already processed manga_ids
        manga_ids_to_process = [m_id for m_id in manga_ids if m_id not in existing_manga_ids]
        logger.info(f"Total manga IDs to process: {len(manga_ids_to_process)} out of {len(manga_ids)}")
        
        if not manga_ids_to_process:
            logger.info("All manga details have already been extracted.")
            return
        
        semaphore = asyncio.Semaphore(1)  # Process one request at a time within each batch

        for i in range(0, len(manga_ids_to_process), batch_size):
            batch = manga_ids_to_process[i:i + batch_size]
            logger.info(f"Processing batch of {len(batch)} manga IDs starting at index {i}")
            start_time = time.time()

            # Process the batch sequentially
            for manga_id in batch:
                result = await self.fetch_with_semaphore(manga_id, semaphore)
                # No need to collect results here since they are saved individually

            # Calculate elapsed time and wait if necessary to respect rate limit
            elapsed = time.time() - start_time
            if elapsed < 60:
                wait_time = 60 - elapsed
                logger.info(f"Batch completed in {elapsed:.2f}s. Waiting {wait_time:.2f}s before next batch.")
                await asyncio.sleep(wait_time)
            else:
                logger.info(f"Batch took {elapsed:.2f}s, which is over 60s. Proceeding immediately.")

        logger.info("Finished extracting new manga details")

    async def fetch_with_semaphore(self, manga_id, semaphore):
        """Fetch manga details with semaphore control"""
        async with semaphore:
            try:
                url = f"{self.base_url}/manga/{manga_id}/full"
                async with aiohttp.ClientSession() as session:
                    data = await self.fetch_page(session, url)
                    if data and 'data' in data:
                        filepath = os.path.join(self.raw_data_dir, f"manga_{manga_id}.json")
                        save_json(data['data'], filepath)
                        return data['data']
                    else:
                        return None
            except Exception as e:
                logger.error(f"Failed to fetch details for manga ID {manga_id}: {str(e)}")
                return None

    def run_extraction(self, page_limit=None):
        """Run the full extraction process"""
        loop = asyncio.get_event_loop()
        manga_list = loop.run_until_complete(self.extract_manga_list(page_limit))
        
        # Extract IDs for detailed information
        manga_ids = [manga['mal_id'] for manga in manga_list]
        loop.run_until_complete(self.extract_manga_details(manga_ids))
        
        # Collect all individual manga details into manga_details.json
        manga_details = []
        for filename in os.listdir(self.raw_data_dir):
            if filename.startswith('manga_') and filename.endswith('.json'):
                id_str = filename[len('manga_'):-len('.json')]
                if id_str.isdigit():
                    with open(os.path.join(self.raw_data_dir, filename), 'r') as f:
                        manga_details.append(json.load(f))
        save_json(manga_details, os.path.join(self.raw_data_dir, "manga_details.json"))
        logger.info(f"Saved all manga details to manga_details.json")
        
        return len(manga_list)

# Run extraction if called directly
if __name__ == "__main__":
    extractor = MangaExtractor()
    extractor.run_extraction(page_limit=20)  # Limit to 20 pages for testing