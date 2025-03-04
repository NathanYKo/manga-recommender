# run_etl.py
import logging
import argparse
from etl.extract import MangaExtractor
from etl.transform import MangaTransformer
from etl.load import MangaLoader

logger = logging.getLogger('manga_recommender.etl_runner')

def run_full_etl(page_limit=None):
    """Run the complete ETL process"""
    # Extract
    logger.info("Starting extraction process...")
    extractor = MangaExtractor()
    extraction_result = extractor.run_extraction(page_limit)
    logger.info(f"Extraction completed: {extraction_result} manga extracted")
    
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
    
    return {
        'extraction': extraction_result,
        'transformation': transformation_result,
        'loading': loading_result
    }

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Run the Manga Recommender ETL process')
    parser.add_argument('--pages', type=int, help='Limit the number of pages to extract', default=None)
    args = parser.parse_args()
    
    result = run_full_etl(args.pages)
    print(f"ETL process completed successfully: {result}")