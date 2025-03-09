# models/content_based.py
import pandas as pd
import numpy as np
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity
import logging
from utils.helpers import execute_query

logger = logging.getLogger('manga_recommender.content_based')

class ContentBasedRecommender:
    def __init__(self):
        self.manga_df = None
        self.tfidf_matrix = None
        self.tfidf_feature_names = None
        self.cosine_sim = None
        self.indices = None
    
    def _load_manga_data(self):
        """Load manga data from database"""
        query = """
        SELECT m.manga_id, m.title, m.synopsis, 
               m.score, m.popularity, m.status,
               STRING_AGG(g.name, ' ') AS genres
        FROM manga m
        LEFT JOIN manga_genres mg ON m.manga_id = mg.manga_id
        LEFT JOIN genres g ON mg.genre_id = g.genre_id
        GROUP BY m.manga_id
        """
        
        result = execute_query(query)
        # Create DataFrame directly from the result list of dictionaries
        self.manga_df = pd.DataFrame(result)
        logger.info(f"Loaded {len(self.manga_df)} manga entries for content-based filtering")
        
        # Fill NaN values
        self.manga_df['genres'] = self.manga_df['genres'].fillna('')
        self.manga_df['synopsis'] = self.manga_df['synopsis'].fillna('')
    
    def _create_content_features(self):
        """Create content features for TF-IDF"""
        # Combine synopsis and genres for content features
        self.manga_df['content'] = self.manga_df['synopsis'] + ' ' + self.manga_df['genres']
        
        # Create TF-IDF matrix
        tfidf = TfidfVectorizer(stop_words='english', max_features=5000)
        self.tfidf_matrix = tfidf.fit_transform(self.manga_df['content'])
        self.tfidf_feature_names = tfidf.get_feature_names_out()
        
        # Compute cosine similarity matrix
        self.cosine_sim = cosine_similarity(self.tfidf_matrix, self.tfidf_matrix)
        
        # Create a mapping of manga titles to indices
        self.indices = pd.Series(self.manga_df.index, index=self.manga_df['title']).drop_duplicates()
        
        logger.info(f"Created TF-IDF matrix with shape {self.tfidf_matrix.shape} and cosine similarity matrix")
    
    def fit(self):
        """Fit the content-based recommender model"""
        self._load_manga_data()
        self._create_content_features()
        logger.info("Content-based recommender model fitted successfully")
        return self
    
    def get_recommendations_by_title(self, title, top_n=10):
        """Get manga recommendations based on title similarity"""
        if self.manga_df is None or self.cosine_sim is None:
            self.fit()
        
        # Check if title exists in the dataset
        if title not in self.indices:
            closest_titles = self.manga_df['title'].str.lower().str.contains(title.lower())
            if closest_titles.any():
                title = self.manga_df.loc[closest_titles, 'title'].iloc[0]
                logger.info(f"Title not found. Using closest match: {title}")
            else:
                logger.warning(f"Title '{title}' not found and no close matches")
                return pd.DataFrame()
        
        # Get the index of the manga with the given title
        idx = self.indices[title]
        
        # Get the similarity scores for all manga
        sim_scores = list(enumerate(self.cosine_sim[idx]))
        
        # Sort manga based on similarity scores
        sim_scores = sorted(sim_scores, key=lambda x: x[1], reverse=True)
        
        # Get the top N most similar manga
        sim_scores = sim_scores[1:top_n+1]  # Skip the first one as it's the input manga
        
        # Get the manga indices
        manga_indices = [i[0] for i in sim_scores]
        
        # Return the top N similar manga
        recommendations = self.manga_df.iloc[manga_indices].copy()
        recommendations['similarity'] = [i[1] for i in sim_scores]
        
        return recommendations[['manga_id', 'title', 'score', 'genres', 'similarity']]
    
    def get_recommendations_by_id(self, manga_id, top_n=10):
        """Get manga recommendations based on manga ID"""
        if self.manga_df is None or self.cosine_sim is None:
            self.fit()
        
        # Find the manga by ID
        manga_row = self.manga_df[self.manga_df['manga_id'] == manga_id]
        if manga_row.empty:
            logger.warning(f"Manga ID {manga_id} not found")
            return pd.DataFrame()
        
        # Get the index of the manga with the given ID
        idx = manga_row.index[0]
        title = manga_row['title'].iloc[0]
        
        # Get the similarity scores for all manga
        sim_scores = list(enumerate(self.cosine_sim[idx]))
        
        # Sort manga based on similarity scores
        sim_scores = sorted(sim_scores, key=lambda x: x[1], reverse=True)
        
        # Get the top N most similar manga
        sim_scores = sim_scores[1:top_n+1]  # Skip the first one as it's the input manga
        
        # Get the manga indices
        manga_indices = [i[0] for i in sim_scores]
        
        # Return the top N similar manga
        recommendations = self.manga_df.iloc[manga_indices].copy()
        recommendations['similarity'] = [i[1] for i in sim_scores]
        
        logger.info(f"Generated {len(recommendations)} content-based recommendations for '{title}'")
        return recommendations[['manga_id', 'title', 'score', 'genres', 'similarity']]
    
    def get_feature_importance(self, manga_id):
        """Get the most important features/terms for a manga"""
        if self.manga_df is None or self.tfidf_matrix is None:
            self.fit()
        
        manga_row = self.manga_df[self.manga_df['manga_id'] == manga_id]
        if manga_row.empty:
            logger.warning(f"Manga ID {manga_id} not found")
            return pd.DataFrame()
        
        idx = manga_row.index[0]
        
        # Get the TF-IDF vector for this manga
        tfidf_vector = self.tfidf_matrix[idx].toarray().flatten()
        
        # Create a DataFrame with feature names and their TF-IDF values
        feature_df = pd.DataFrame({
            'feature': self.tfidf_feature_names,
            'tfidf': tfidf_vector
        })
        
        # Sort by importance (TF-IDF value)
        feature_df = feature_df.sort_values('tfidf', ascending=False)
        
        # Return only non-zero features
        return feature_df[feature_df['tfidf'] > 0]

# Run if called directly for testing
if __name__ == "__main__":
    recommender = ContentBasedRecommender()
    recommender.fit()
    
    # Test with a sample manga
    test_title = "Naruto"
    recommendations = recommender.get_recommendations_by_title(test_title)
    
    print(f"Top recommendations for {test_title}:")
    print(recommendations)