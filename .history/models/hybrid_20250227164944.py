# models/hybrid.py
import pandas as pd
import numpy as np
import logging
from models.content_based import ContentBasedRecommender
from models.collaborative import CollaborativeFilteringRecommender

logger = logging.getLogger('manga_recommender.hybrid')

class HybridRecommender:
    def __init__(self, content_weight=0.5, collab_weight=0.5):
        """
        Initialize the hybrid recommender
        
        Parameters:
        -----------
        content_weight : float
            Weight for content-based recommendations (0-1)
        collab_weight : float
            Weight for collaborative filtering recommendations (0-1)
        """
        self.content_based = ContentBasedRecommender()
        self.collaborative = CollaborativeFilteringRecommender()
        self.content_weight = content_weight
        self.collab_weight = collab_weight
        
        # Normalize weights
        total_weight = content_weight + collab_weight
        self.content_weight = content_weight / total_weight
        self.collab_weight = collab_weight / total_weight
    
    def fit(self):
        """Fit both recommendation models"""
        logger.info("Fitting content-based recommender...")
        self.content_based.fit()
        
        logger.info("Fitting collaborative filtering recommender...")
        self.collaborative.fit()
        
        logger.info("Hybrid recommender fitted successfully")
        return self
    
    def get_recommendations_by_id(self, manga_id, top_n=10):
        """
        Get hybrid recommendations based on manga ID
        
        Parameters:
        -----------
        manga_id : int
            ID of the manga to base recommendations on
        top_n : int
            Number of recommendations to return
            
        Returns:
        --------
        DataFrame
            Hybrid recommendations with scores
        """
        # Get content-based recommendations
        content_recommendations = self.content_based.get_recommendations_by_id(manga_id, top_n=top_n*2)
        
        # Get collaborative filtering recommendations
        collab_recommendations = self.collaborative.get_recommendations_by_id(manga_id, top_n=top_n*2)
        
        # If either method fails, return recommendations from the other
        if content_recommendations.empty and collab_recommendations.empty:
            logger.warning(f"Both recommendation methods failed for manga ID {manga_id}")
            return pd.DataFrame()
        elif content_recommendations.empty:
            logger.warning(f"Content-based recommendations failed for manga ID {manga_id}, using only collaborative")
            return collab_recommendations.head(top_n)
        elif collab_recommendations.empty:
            logger.warning(f"Collaborative recommendations failed for manga ID {manga_id}, using only content-based")
            return content_recommendations.head(top_n)
        
        # Scale similarity scores to 0-1 range for each method
        content_max = content_recommendations['similarity'].max()
        collab_max = collab_recommendations['similarity'].max()
        
        content_recommendations['normalized_similarity'] = content_recommendations['similarity'] / content_max if content_max > 0 else 0
        collab_recommendations['normalized_similarity'] = collab_recommendations['similarity'] / collab_max if collab_max > 0 else 0
        
        # Merge recommendations
        content_recommendations = content_recommendations[['manga_id', 'title', 'normalized_similarity']]
        content_recommendations.columns = ['manga_id', 'title', 'content_similarity']
        
        collab_recommendations = collab_recommendations[['manga_id', 'normalized_similarity']]
        collab_recommendations.columns = ['manga_id', 'collab_similarity']
        
        # Full outer join
        hybrid_recommendations = pd.merge(
            content_recommendations, 
            collab_recommendations,
            on='manga_id',
            how='outer'
        ).fillna(0)
        
        # Calculate weighted score
        hybrid_recommendations['hybrid_score'] = (
            self.content_weight * hybrid_recommendations['content_similarity'] +
            self.collab_weight * hybrid_recommendations['collab_similarity']
        )
        
        # Sort by hybrid score
        hybrid_recommendations = hybrid_recommendations.sort_values('hybrid_score', ascending=False)
        
        # Keep only top_n recommendations
        hybrid_recommendations = hybrid_recommendations.head(top_n)
        
        logger.info(f"Generated {len(hybrid_recommendations)} hybrid recommendations for manga ID {manga_id}")
        
        return hybrid_recommendations[['manga_id', 'title', 'content_similarity', 'collab_similarity', 'hybrid_score']]
    
    def get_personalized_recommendations(self, user_id, top_n=10, exclude_rated=True, include_content=True):
        """
        Get personalized recommendations for a user
        
        Parameters:
        -----------
        user_id : int
            User ID to get recommendations for
        top_n : int
            Number of recommendations to return
        exclude_rated : bool
            Whether to exclude manga already rated by the user
        include_content : bool
            Whether to include content-based suggestions for manga the user has rated highly
            
        Returns:
        --------
        DataFrame
            Personalized recommendations
        """
        # Get collaborative recommendations for the user
        collab_recommendations = self.collaborative.get_recommendations_for_user(
            user_id, top_n=top_n*2, exclude_rated=exclude_rated
        )
        
        if collab_recommendations.empty:
            logger.warning(f"No collaborative recommendations for user {user_id}")
            return pd.DataFrame()
        
        # If we don't want to include content-based suggestions, return just collaborative
        if not include_content:
            return collab_recommendations.head(top_n)
        
        # Get the user's top-rated manga
        user_ratings = self.collaborative.ratings_df[self.collaborative.ratings_df['user_id'] == user_id]
        
        if user_ratings.empty:
            logger.warning(f"No ratings found for user {user_id}")
            return collab_recommendations.head(top_n)
        
        # Sort by rating and take top 3
        top_manga = user_ratings.sort_values('rating', ascending=False).head(3)
        
        # Get content-based recommendations for each top manga
        content_recommendations = pd.DataFrame()
        
        for _, row in top_manga.iterrows():
            manga_id = row['manga_id']
            user_rating = row['rating']
            
            # Only consider manga the user rated highly (7+ out of 10)
            if user_rating >= 7:
                manga_recs = self.content_based.get_recommendations_by_id(manga_id, top_n=5)
                
                if not manga_recs.empty:
                    # Weight by user rating
                    manga_recs['weighted_similarity'] = manga_recs['similarity'] * (user_rating / 10)
                    
                    # Add to overall content recommendations
                    if content_recommendations.empty:
                        content_recommendations = manga_recs
                    else:
                        content_recommendations = pd.concat([content_recommendations, manga_recs])
        
        # If no content recommendations, return just collaborative
        if content_recommendations.empty:
            logger.info(f"No content-based recommendations for user {user_id}, using only collaborative")
            return collab_recommendations.head(top_n)
        
        # Remove duplicates, keeping highest weighted similarity
        content_recommendations = content_recommendations.sort_values('weighted_similarity', ascending=False)
        content_recommendations = content_recommendations.drop_duplicates(subset=['manga_id'])
        
        # Exclude manga already rated if requested
        if exclude_rated:
            rated_manga_ids = user_ratings['manga_id'].tolist()
            content_recommendations = content_recommendations[~content_recommendations['manga_id'].isin(rated_manga_ids)]
        
        # Normalize collab scores
        collab_max = collab_recommendations['predicted_rating'].max()
        collab_recommendations['normalized_score'] = collab_recommendations['predicted_rating'] / collab_max if collab_max > 0 else 0
        
        # Prepare for merge
        content_slim = content_recommendations[['manga_id', 'weighted_similarity']]
        collab_slim = collab_recommendations[['manga_id', 'normalized_score']]
        
        # Merge recommendations (outer join)
        hybrid_recommendations = pd.merge(
            content_slim,
            collab_slim,
            on='manga_id',
            how='outer'
        ).fillna(0)
        
        # Calculate hybrid score
        hybrid_recommendations['hybrid_score'] = (
            self.content_weight * hybrid_recommendations['weighted_similarity'] +
            self.collab_weight * hybrid_recommendations['normalized_score']
        )
        
        # Sort by hybrid score
        hybrid_recommendations = hybrid_recommendations.sort_values('hybrid_score', ascending=False)
        
        # Keep only top_n recommendations
        hybrid_recommendations = hybrid_recommendations.head(top_n)
        
        # Get manga details
        manga_ids = hybrid_recommendations['manga_id'].tolist()
        manga_details = self.content_based.manga_df[self.content_based.manga_df['manga_id'].isin(manga_ids)]
        
        # Final merge to get complete recommendations
        final_recommendations = pd.merge(
            hybrid_recommendations,
            manga_details[['manga_id', 'title', 'score', 'genres']],
            on='manga_id'
        )
        
        logger.info(f"Generated {len(final_recommendations)} personalized hybrid recommendations for user {user_id}")
        
        return final_recommendations[['manga_id', 'title', 'score', 'genres', 'hybrid_score']]

# Run if called directly for testing
if __name__ == "__main__":
    recommender = HybridRecommender(content_weight=0.7, collab_weight=0.3)
    recommender.fit()
    
    # Test with a sample manga ID
    test_manga_id = 1  # Replace with a valid manga ID
    recommendations = recommender.get_recommendations_by_id(test_manga_id)
    
    print(f"Top hybrid recommendations for manga ID {test_manga_id}:")
    print(recommendations)