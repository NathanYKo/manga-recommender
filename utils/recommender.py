class HybridRecommender:
    def get_personalized_recommendations(self, user_id, top_n=10):
        # Add content-based filtering
        user_preferences = self.get_user_genre_preferences(user_id)
        
        # Add collaborative filtering
        similar_users = self.find_similar_users(user_id)
        
        # Add popularity bias
        popular_weights = self.calculate_popularity_weights()
        
        # Combine all signals
        recommendations = self.combine_recommendation_signals(
            user_preferences,
            similar_users,
            popular_weights
        )
        return recommendations 