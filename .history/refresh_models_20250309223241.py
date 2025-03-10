#!/usr/bin/env python3
"""
Script to refresh recommendation models without restarting the web application.
This script can be scheduled to run periodically (e.g., via cron) to keep your 
recommendation models up to date with new manga data.
"""

import os
import sys
import logging
from dotenv import load_dotenv
from datetime import datetime

# Set up logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        logging.StreamHandler(),
        logging.FileHandler('model_refresh.log')
    ]
)
logger = logging.getLogger('model_refresh')

# Load environment variables
load_dotenv()

def refresh_models():
    """Refresh all recommendation models"""
    start_time = datetime.now()
    logger.info(f"Starting model refresh process at {start_time}")
    
    try:
        # Import recommender models
        from models.content_based import ContentBasedRecommender
        from models.collaborative import CollaborativeFilteringRecommender
        from models.hybrid import HybridRecommender
        
        # Refit content-based recommender
        logger.info("Refreshing content-based recommender...")
        content_based = ContentBasedRecommender()
        content_based.fit()
        
        # Refit collaborative recommender
        logger.info("Refreshing collaborative filtering recommender...")
        collaborative = CollaborativeFilteringRecommender()
        collaborative.fit()
        
        # Refit hybrid recommender
        logger.info("Refreshing hybrid recommender...")
        hybrid = HybridRecommender(content_weight=0.7, collab_weight=0.3)
        hybrid.fit()
        
        # Write timestamp to indicate successful refresh
        with open('last_model_refresh.txt', 'w') as f:
            f.write(f"Last successful model refresh: {datetime.now()}")
        
        end_time = datetime.now()
        duration = end_time - start_time
        logger.info(f"Model refresh completed successfully in {duration}")
        
        return True
    except Exception as e:
        logger.error(f"Error refreshing models: {e}")
        return False

if __name__ == "__main__":
    refresh_models() 