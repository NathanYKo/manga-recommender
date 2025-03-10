# models/collaborative.py
import pandas as pd
import numpy as np
from scipy.sparse import csr_matrix
from sklearn.neighbors import NearestNeighbors
import logging
from utils.helpers import execute_query

logger = logging.getLogger('manga_recommender.collaborative')

class CollaborativeFilteringRecommender:
    def __init__(self, min_ratings=0):
        """Initialize collaborative filtering recommender
        
        Args:
            min_ratings: Minimum number of ratings a manga must have to be included (default: 0 to include all manga)
        """
        self.min_ratings = min_ratings
        self.manga_df = None
        self.ratings_df = None
        self.model = None
        self.user_manga_matrix = None
        self.manga_user_matrix = None
        self.manga_indices = None
    
    def _load_data(self):
        """Load manga and user ratings data from database"""
        # Load manga data
        manga_query = """
        SELECT manga_id, title, score
        FROM manga 
        WHERE score IS NOT NULL
        ORDER BY score DESC
        LIMIT 2000
        """
        
        manga_result = execute_query(manga_query)
        self.manga_df = pd.DataFrame(manga_result)
        
        # Load user ratings
        ratings_query = """
        SELECT user_id, manga_id, rating
        FROM user_ratings
        """
        
        ratings_result = execute_query(ratings_query)
        self.ratings_df = pd.DataFrame(ratings_result)
        
        logger.info(f"Loaded {len(self.manga_df)} manga and {len(self.ratings_df)} ratings")
        
        # If we don't have enough user ratings, use the API score as a fallback
        if len(self.ratings_df) < 100:
            logger.warning("Not enough user ratings. Using API scores as fallback.")
            # Create synthetic ratings from API scores
            user_ids = list(range(1, 101))  # Create 100 synthetic users
            synthetic_ratings = []
            
            for _, manga in self.manga_df.iterrows():
                if manga['score'] is not None:
                    # Distribute ratings around the API score with some variance
                    popularity = float(manga['popularity']) if manga['popularity'] else 0
                    # Limit the number of ratings to the available users
                    num_ratings = min(len(user_ids), max(5, int(popularity / 100)))
                    selected_users = np.random.choice(user_ids, size=num_ratings, replace=False)
                    
                    for user_id in selected_users:
                        # Convert score to float and add some noise to create variance
                        score_float = float(manga['score'])
                        rating = min(10, max(1, score_float + np.random.normal(0, 1)))
                        synthetic_ratings.append({
                            'user_id': user_id,
                            'manga_id': manga['manga_id'],
                            'rating': rating
                        })
            
            self.ratings_df = pd.DataFrame(synthetic_ratings)
            logger.info(f"Created {len(synthetic_ratings)} synthetic ratings as fallback")
    
    def _create_matrix(self):
        """Create user-manga and manga-user matrices"""
        # If min_ratings > 0, filter out manga with too few ratings
        if self.min_ratings > 0:
            manga_rating_counts = self.ratings_df['manga_id'].value_counts()
            qualified_manga = manga_rating_counts[manga_rating_counts >= self.min_ratings].index
            qualified_ratings = self.ratings_df[self.ratings_df['manga_id'].isin(qualified_manga)]
        else:
            # Use all ratings without filtering
            qualified_ratings = self.ratings_df
            
        logger.info(f"Using {len(qualified_ratings)} ratings for {len(qualified_ratings['manga_id'].unique())} manga after filtering")
        
        # Create user-manga matrix (pivot table)
        user_manga_df = qualified_ratings.pivot(index='user_id', columns='manga_id', values='rating').fillna(0)
        
        # Convert to sparse matrix for efficiency
        self.user_manga_matrix = csr_matrix(user_manga_df.values)
        
        # Transpose for item-based filtering
        self.manga_user_matrix = csr_matrix(user_manga_df.values.T)
        
        # Create mapping of manga_id to matrix position
        self.manga_indices = {manga_id: i for i, manga_id in enumerate(user_manga_df.columns)}
        
        logger.info(f"Created user-manga matrix with shape {self.user_manga_matrix.shape} and manga-user matrix with shape {self.manga_user_matrix.shape}")
    
    def fit(self, k=10, metric='cosine', algorithm='brute'):
        """Fit the collaborative filtering model using k-nearest neighbors"""
        self._load_data()
        
        if len(self.ratings_df) == 0:
            logger.error("No ratings data available. Cannot fit collaborative model.")
            return self
        
        self._create_matrix()
        
        if self.manga_user_matrix.shape[0] == 0:
            logger.error("No manga qualified for collaborative filtering after filtering.")
            return self
        
        # Initialize the model
        self.model = NearestNeighbors(n_neighbors=k, metric=metric, algorithm=algorithm)
        
        # Fit the model to our manga-user matrix (item-based collaborative filtering)
        self.model.fit(self.manga_user_matrix)
        
        logger.info(f"Fitted KNN model with {k} neighbors using {metric} metric")
        return self
    
    def get_recommendations_by_id(self, manga_id, top_n=10):
        """Get manga recommendations based on manga ID using collaborative filtering"""
        if self.model is None or self.manga_indices is None:
            self.fit()
        
        # Check if manga_id exists in our model
        if manga_id not in self.manga_indices:
            logger.debug(f"Manga ID {manga_id} not found in collaborative model")
            return pd.DataFrame()
        
        # Get the manga index
        manga_idx = self.manga_indices[manga_id]
        
        # Get K nearest neighbors
        distances, indices = self.model.kneighbors(
            self.manga_user_matrix[manga_idx].reshape(1, -1),
            n_neighbors=top_n+1  # +1 because the manga itself will be included
        )
        
        # Convert model indices back to manga IDs
        manga_ids = [list(self.manga_indices.keys())[list(self.manga_indices.values()).index(idx)] for idx in indices.flatten()]
        
        # Remove the input manga from the list
        distances = distances.flatten()
        indices = indices.flatten()
        
        # Create a list of (manga_id, distance) tuples, excluding the input manga
        recommendations = []
        for i in range(len(distances)):
            if manga_ids[i] != manga_id:  # Skip the input manga
                recommendations.append((manga_ids[i], distances[i]))
        
        if not recommendations:
            logger.warning(f"No recommendations found for manga ID {manga_id}")
            return pd.DataFrame()
        
        # Get manga details and create DataFrame
        rec_manga_ids = [rec[0] for rec in recommendations]
        rec_distances = [rec[1] for rec in recommendations]
        
        # Filter manga DataFrame to get recommendation details
        rec_df = self.manga_df[self.manga_df['manga_id'].isin(rec_manga_ids)].copy()
        
        # Add similarity information (1 - distance for cosine similarity)
        rec_df['similarity'] = [1 - dist for dist in rec_distances[:len(rec_df)]]
        
        # Sort by similarity
        rec_df = rec_df.sort_values('similarity', ascending=False)
        
        # Limit to top_n
        rec_df = rec_df.head(top_n)
        
        # Get original manga title for logging
        manga_title = self.manga_df[self.manga_df['manga_id'] == manga_id]['title'].iloc[0]
        logger.info(f"Generated {len(rec_df)} collaborative recommendations for '{manga_title}'")
        
        return rec_df[['manga_id', 'title', 'score', 'similarity']]
    
    def get_recommendations_for_user(self, user_id, top_n=10, exclude_rated=True):
        """Get manga recommendations for a specific user"""
        if self.model is None or self.user_manga_matrix is None:
            self.fit()
        
        # Check if user exists in our ratings data
        if user_id not in self.ratings_df['user_id'].unique():
            logger.warning(f"User ID {user_id} not found in ratings data")
            return pd.DataFrame()
        
        # Get the manga rated by this user
        user_ratings = self.ratings_df[self.ratings_df['user_id'] == user_id]
        
        # If no manga rated by user qualified for our model, return empty
        rated_manga_ids = set(user_ratings['manga_id'])
        qualified_manga_ids = set(self.manga_indices.keys())
        common_manga_ids = rated_manga_ids.intersection(qualified_manga_ids)
        
        if not common_manga_ids:
            logger.warning(f"User {user_id} has not rated any manga in our collaborative model")
            return pd.DataFrame()
        
        # Initialize recommendation scores
        recommendation_scores = {}
        
        # For each manga the user has rated, get similar manga and their scores
        for manga_id in common_manga_ids:
            # Get the user's rating for this manga
            user_rating = user_ratings[user_ratings['manga_id'] == manga_id]['rating'].iloc[0]
            
            # Get recommendations based on this manga
            similar_manga = self.get_recommendations_by_id(manga_id, top_n=20)
            
            if len(similar_manga) == 0:
                continue
            
            # Weight recommendations by user rating and similarity
            for _, row in similar_manga.iterrows():
                rec_manga_id = row['manga_id']
                similarity = row['similarity']
                
                # Skip manga already rated by user if exclude_rated is True
                if exclude_rated and rec_manga_id in rated_manga_ids:
                    continue
                
                # Calculate weighted score (user_rating * similarity)
                weighted_score = user_rating * similarity
                
                # Add to recommendation scores, accumulating scores for manga recommended multiple times
                if rec_manga_id in recommendation_scores:
                    recommendation_scores[rec_manga_id]['weighted_sum'] += weighted_score
                    recommendation_scores[rec_manga_id]['similarity_sum'] += similarity
                else:
                    recommendation_scores[rec_manga_id] = {
                        'weighted_sum': weighted_score,
                        'similarity_sum': similarity
                    }
        
        if not recommendation_scores:
            logger.warning(f"No recommendations generated for user {user_id}")
            return pd.DataFrame()
        
        # Create recommendations DataFrame
        rec_data = []
        for manga_id, scores in recommendation_scores.items():
            # Calculate final score as weighted average
            final_score = scores['weighted_sum'] / scores['similarity_sum']
            rec_data.append({
                'manga_id': manga_id,
                'predicted_rating': final_score
            })
        
        rec_df = pd.DataFrame(rec_data)
        
        # Sort by predicted rating
        rec_df = rec_df.sort_values('predicted_rating', ascending=False)
        
        # Limit to top_n
        rec_df = rec_df.head(top_n)
        
        # Merge with manga data to get details
        rec_df = pd.merge(rec_df, self.manga_df, on='manga_id')
        
        logger.info(f"Generated {len(rec_df)} personalized recommendations for user {user_id}")
        
        return rec_df[['manga_id', 'title', 'score', 'predicted_rating']]

# Run if called directly for testing
if __name__ == "__main__":
    recommender = CollaborativeFilteringRecommender()
    recommender.fit()
    
    # Test with a sample manga ID
    test_manga_id = 1  # Replace with a valid manga ID
    recommendations = recommender.get_recommendations_by_id(test_manga_id)
    
    print(f"Top collaborative recommendations for manga ID {test_manga_id}:")
    print(recommendations)