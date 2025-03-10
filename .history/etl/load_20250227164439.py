# etl/load.py
import os
import json
import logging
from sqlalchemy import create_engine, text
from sqlalchemy.exc import SQLAlchemyError
from utils.config import config
from utils.helpers import load_json, execute_query

logger = logging.getLogger('manga_recommender.load')

class MangaLoader:
    def __init__(self):
        self.processed_data_dir = os.path.join('data', 'processed')
        self.db_config = config.get_db_config()
        self.engine = create_engine(
            f"postgresql://{self.db_config['user']}:{self.db_config['password']}@{self.db_config['host']}:{self.db_config['port']}/{self.db_config['database']}"
        )
    
    def load_genres(self):
        """Load genres into the database"""
        try:
            genres_path = os.path.join(self.processed_data_dir, "genres.json")
            genres = load_json(genres_path)
            
            inserted_count = 0
            for genre in genres:
                try:
                    query = """
                    INSERT INTO genres (genre_id, name)
                    VALUES (:genre_id, :name)
                    ON CONFLICT (genre_id) DO UPDATE
                    SET name = EXCLUDED.name
                    """
                    execute_query(query, {"genre_id": genre['genre_id'], "name": genre['name']})
                    inserted_count += 1
                except SQLAlchemyError as e:
                    logger.error(f"Error inserting genre {genre['name']}: {str(e)}")
            
            logger.info(f"Loaded {inserted_count} genres into the database")
            return inserted_count
        except FileNotFoundError:
            logger.error("Genres file not found. Please run transformation first.")
            return 0
    
    def load_manga(self):
        """Load manga into the database"""
        try:
            manga_path = os.path.join(self.processed_data_dir, "transformed_manga.json")
            manga_list = load_json(manga_path)
            
            inserted_count = 0
            for manga in manga_list:
                try:
                    # Insert manga
                    query = """
                    INSERT INTO manga (
                        manga_id, title, title_english, title_japanese, synopsis,
                        image_url, score, scored_by, rank, popularity, status,
                        publishing, published_from, published_to, chapters, volumes
                    ) VALUES (
                        :manga_id, :title, :title_english, :title_japanese, :synopsis,
                        :image_url, :score, :scored_by, :rank, :popularity, :status,
                        :publishing, :published_from, :published_to, :chapters, :volumes
                    ) ON CONFLICT (manga_id) DO UPDATE
                    SET
                        title = EXCLUDED.title,
                        title_english = EXCLUDED.title_english,
                        title_japanese = EXCLUDED.title_japanese,
                        synopsis = EXCLUDED.synopsis,
                        image_url = EXCLUDED.image_url,
                        score = EXCLUDED.score,
                        scored_by = EXCLUDED.scored_by,
                        rank = EXCLUDED.rank,
                        popularity = EXCLUDED.popularity,
                        status = EXCLUDED.status,
                        publishing = EXCLUDED.publishing,
                        published_from = EXCLUDED.published_from,
                        published_to = EXCLUDED.published_to,
                        chapters = EXCLUDED.chapters,
                        volumes = EXCLUDED.volumes,
                        updated_at = CURRENT_TIMESTAMP
                    """
                    
                    # Extract date strings from manga data
                    manga_params = manga.copy()
                    if 'published_from' in manga_params and manga_params['published_from']:
                        if isinstance(manga_params['published_from'], dict):
                            manga_params['published_from'] = manga_params['published_from'].get('$date', None)
                    if 'published_to' in manga_params and manga_params['published_to']:
                        if isinstance(manga_params['published_to'], dict):
                            manga_params['published_to'] = manga_params['published_to'].get('$date', None)
                    
                    # Remove genres from params as they're handled separately
                    genres = manga_params.pop('genres', [])
                    
                    execute_query(query, manga_params)
                    
                    # Insert manga-genre relationships
                    for genre in genres:
                        genre_query = """
                        INSERT INTO manga_genres (manga_id, genre_id)
                        VALUES (:manga_id, :genre_id)
                        ON CONFLICT (manga_id, genre_id) DO NOTHING
                        """
                        execute_query(genre_query, {
                            "manga_id": manga['manga_id'],
                            "genre_id": genre['genre_id']
                        })
                    
                    inserted_count += 1
                except SQLAlchemyError as e:
                    logger.error(f"Error inserting manga {manga['title']}: {str(e)}")
            
            logger.info(f"Loaded {inserted_count} manga into the database")
            return inserted_count
        except FileNotFoundError:
            logger.error("Transformed manga file not found. Please run transformation first.")
            return 0
    
    def load_enhanced_manga(self):
        """Load enhanced manga data if available"""
        try:
            enhanced_path = os.path.join(self.processed_data_dir, "enhanced_manga.json")
            enhanced_manga = load_json(enhanced_path)
            
            # This would be where you add the additional information
            # For now, we'll just log that it was found
            logger.info(f"Found {len(enhanced_manga)} enhanced manga entries. Additional loading logic would go here.")
            return len(enhanced_manga)
        except FileNotFoundError:
            logger.warning("Enhanced manga file not found. Skipping enhanced data loading.")
            return 0
    
    def run_loading(self):
        """Run the full loading process"""
        genres_count = self.load_genres()
        manga_count = self.load_manga()
        enhanced_count = self.load_enhanced_manga()
        
        return {
            'genres_count': genres_count,
            'manga_count': manga_count,
            'enhanced_count': enhanced_count
        }

# Run loading if called directly
if __name__ == "__main__":
    loader = MangaLoader()
    result = loader.run_loading()
    print(f"Loading completed: {result}")