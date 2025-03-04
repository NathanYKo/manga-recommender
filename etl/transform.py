# etl/transform.py
import os
import json
import pandas as pd
from datetime import datetime
import logging
from utils.helpers import load_json, save_json, ensure_directory

logger = logging.getLogger('manga_recommender.transform')

class MangaTransformer:
    def __init__(self):
        self.raw_data_dir = os.path.join('data', 'raw')
        self.processed_data_dir = os.path.join('data', 'processed')
        ensure_directory(self.processed_data_dir)
    
    def parse_date(self, date_str):
        """Parse date string to datetime object"""
        if not date_str:
            return None
        try:
            return datetime.fromisoformat(date_str.replace('Z', '+00:00'))
        except (ValueError, AttributeError):
            return None
    
    def transform_manga_list(self):
        """Transform the manga list data"""
        try:
            manga_list_path = os.path.join(self.raw_data_dir, "manga_list.json")
            manga_list = load_json(manga_list_path)
        except FileNotFoundError:
            logger.error("Manga list file not found. Please run extraction first.")
            return None
        
        transformed_manga = []
        genres_set = set()
        
        for manga in manga_list:
            manga_data = {
                'manga_id': manga.get('mal_id'),
                'title': manga.get('title', ''),
                'title_english': manga.get('title_english', ''),
                'title_japanese': manga.get('title_japanese', ''),
                'synopsis': manga.get('synopsis', ''),
                'image_url': manga.get('images', {}).get('jpg', {}).get('large_image_url', ''),
                'score': manga.get('score'),
                'scored_by': manga.get('scored_by'),
                'rank': manga.get('rank'),
                'popularity': manga.get('popularity'),
                'status': manga.get('status', ''),
                'publishing': manga.get('publishing', False),
                'chapters': manga.get('chapters'),
                'volumes': manga.get('volumes')
            }
            
            # Parse dates and convert to ISO 8601 strings
            published_from = self.parse_date(manga.get('published', {}).get('from'))
            published_to = self.parse_date(manga.get('published', {}).get('to'))
            manga_data['published_from'] = published_from.isoformat() if published_from else None
            manga_data['published_to'] = published_to.isoformat() if published_to else None
            
            # Extract genres
            genres = []
            if 'genres' in manga:
                for genre in manga['genres']:
                    genre_id = genre.get('mal_id')
                    genre_name = genre.get('name')
                    genres.append({'genre_id': genre_id, 'name': genre_name})
                    genres_set.add((genre_id, genre_name))
            
            manga_data['genres'] = genres
            transformed_manga.append(manga_data)
        
        # Extract unique genres
        genres_list = [{'genre_id': genre_id, 'name': name} for genre_id, name in genres_set]
        
        # Save transformed data
        save_json(transformed_manga, os.path.join(self.processed_data_dir, "transformed_manga.json"))
        save_json(genres_list, os.path.join(self.processed_data_dir, "genres.json"))
        
        logger.info(f"Transformed {len(transformed_manga)} manga entries with {len(genres_list)} unique genres")
        return transformed_manga, genres_list
    def transform_manga_details(self):
        """Transform detailed manga information"""
        manga_details_path = os.path.join(self.raw_data_dir, "manga_details.json")
        try:
            manga_details = load_json(manga_details_path)
        except FileNotFoundError:
            # If detailed info not available, we'll just use the basic info
            logger.warning("Manga details file not found. Using basic manga information only.")
            return None
        
        # Here you could extract additional information from the detailed data
        # such as recommendations, relations, etc.
        
        enhanced_manga = []
        
        for manga in manga_details:
            enhanced_data = {
                'manga_id': manga.get('mal_id'),
                'background': manga.get('background', ''),
                'relations': manga.get('relations', []),
                'recommendations': manga.get('recommendations', [])
            }
            enhanced_manga.append(enhanced_data)
        
        save_json(enhanced_manga, os.path.join(self.processed_data_dir, "enhanced_manga.json"))
        logger.info(f"Transformed {len(enhanced_manga)} detailed manga entries")
        return enhanced_manga
    
    def run_transformation(self):
        """Run the full transformation process"""
        manga_data, genres_data = self.transform_manga_list()
        enhanced_data = self.transform_manga_details()
        
        return {
            'manga_count': len(manga_data) if manga_data else 0,
            'genres_count': len(genres_data) if genres_data else 0,
            'enhanced_count': len(enhanced_data) if enhanced_data else 0
        }

# Run transformation if called directly
if __name__ == "__main__":
    transformer = MangaTransformer()
    result = transformer.run_transformation()
    print(f"Transformation completed: {result}")