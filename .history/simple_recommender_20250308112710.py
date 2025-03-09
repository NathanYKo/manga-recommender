#!/usr/bin/env python
# simple_recommender.py
"""
A simpler version of the Manga Recommender CLI that minimizes dependencies.
"""

import argparse
import json
import logging
import sys
from utils.helpers import execute_query, standardize_manga_fields
from utils.config import config

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger('manga_recommender.simple_cli')

def find_manga_by_title(title, limit=5):
    """Find manga by title using a fuzzy search"""
    query = """
    SELECT manga_id, title, title_english, score
    FROM manga
    WHERE LOWER(title) LIKE LOWER(%s)
    OR LOWER(title_english) LIKE LOWER(%s)
    ORDER BY popularity DESC
    LIMIT %s
    """
    search_term = f"%{title}%"
    results = execute_query(query, (search_term, search_term, limit))
    return results

def get_manga_details(manga_id):
    """Get detailed information about a manga"""
    query = """
    SELECT m.*, STRING_AGG(DISTINCT g.name, ', ') as genre_list
    FROM manga m
    LEFT JOIN manga_genres mg ON m.manga_id = mg.manga_id
    LEFT JOIN genres g ON mg.genre_id = g.genre_id
    WHERE m.manga_id = %s
    GROUP BY m.manga_id
    """
    manga = execute_query(query, (manga_id,), fetch_one=True)
    
    if not manga:
        logger.error(f"Manga ID {manga_id} not found")
        return None
    
    # Standardize fields
    standardize_manga_fields(manga)
    return manga

def get_similar_manga(manga_id, top_n=10):
    """Get similar manga using direct SQL query rather than the recommender model"""
    # First, get the genres of the input manga
    genre_query = """
    SELECT STRING_AGG(g.name, ',') as genres
    FROM manga_genres mg 
    JOIN genres g ON mg.genre_id = g.genre_id
    WHERE mg.manga_id = %s
    """
    genre_result = execute_query(genre_query, (manga_id,), fetch_one=True)
    
    if not genre_result or not genre_result['genres']:
        logger.warning(f"No genres found for manga ID {manga_id}")
        return []
    
    # Get similar manga by matching genres and score
    genres = genre_result['genres'].split(',')
    placeholders = ', '.join(['%s'] * len(genres))
    
    similar_query = f"""
    SELECT DISTINCT m.manga_id, m.title, m.score, m.popularity, m.image_url, 
           m.status, m.synopsis, STRING_AGG(DISTINCT g.name, ', ') as genre_list,
           COUNT(DISTINCT g.genre_id) as matching_genres
    FROM manga m
    JOIN manga_genres mg ON m.manga_id = mg.manga_id
    JOIN genres g ON mg.genre_id = g.genre_id
    WHERE g.name IN ({placeholders})
    AND m.manga_id != %s
    GROUP BY m.manga_id, m.title, m.score, m.popularity, m.image_url, m.status, m.synopsis
    ORDER BY matching_genres DESC, m.score DESC
    LIMIT %s
    """
    
    params = genres + [manga_id, top_n]
    similar_manga = execute_query(similar_query, tuple(params))
    
    # Standardize fields
    standardize_manga_fields(similar_manga)
    
    return similar_manga

def format_manga_info(manga):
    """Format manga information for display"""
    if not manga:
        return "Manga not found"
    
    info = [
        f"Title: {manga['title']}",
        f"ID: {manga['manga_id']}",
        f"Score: {manga['score']}" if manga.get('score') else "Score: N/A",
        f"Status: {manga['status']}" if manga.get('status') else "Status: N/A",
        f"Published: {manga.get('published_from_formatted', 'N/A')} to {manga.get('published_to_formatted', 'N/A')}",
        f"Genres: {manga.get('genre_list', 'N/A')}",
        f"Synopsis: {manga.get('synopsis', 'No synopsis available')}"
    ]
    
    return "\n".join(info)

def format_recommendations(recommendations):
    """Format recommendations for display"""
    if not recommendations:
        return "No recommendations found"
    
    result = []
    for i, rec in enumerate(recommendations, 1):
        rec_info = [
            f"{i}. {rec['title']} (ID: {rec['manga_id']})",
            f"   Score: {rec.get('score', 'N/A')}, Matching Genres: {rec.get('matching_genres', 'N/A')}",
            f"   Genres: {rec.get('genre_list', 'N/A')}",
            f"   Status: {rec.get('status', 'N/A')}"
        ]
        result.append("\n".join(rec_info))
    
    return "\n\n".join(result)

def main():
    """Main function for CLI"""
    parser = argparse.ArgumentParser(description="Simple Manga Recommender CLI")
    
    # Create mutually exclusive group for search methods
    search_group = parser.add_mutually_exclusive_group(required=True)
    search_group.add_argument("-i", "--id", type=int, help="Manga ID to get recommendations for")
    search_group.add_argument("-t", "--title", type=str, help="Manga title to search for")
    
    # Other arguments
    parser.add_argument("-n", "--num", type=int, default=10, help="Number of recommendations to show (default: 10)")
    parser.add_argument("-j", "--json", action="store_true", help="Output in JSON format")
    parser.add_argument("-d", "--details-only", action="store_true", help="Show only manga details without recommendations")
    
    args = parser.parse_args()
    
    manga_id = args.id
    
    # If title is provided, search for the manga
    if args.title:
        logger.info(f"Searching for manga with title containing: {args.title}")
        results = find_manga_by_title(args.title)
        
        if not results:
            print(f"No manga found with title containing: {args.title}")
            return 1
        
        if len(results) > 1 and not args.json:
            print("Found multiple manga titles:")
            for i, manga in enumerate(results, 1):
                print(f"{i}. {manga['title']} (ID: {manga['manga_id']}, Score: {manga['score']})")
            
            try:
                choice = int(input("\nSelect a manga (number) or 0 to exit: "))
                if choice == 0 or choice > len(results):
                    return 0
                manga_id = results[choice-1]['manga_id']
            except (ValueError, IndexError):
                print("Invalid selection")
                return 1
        else:
            # Just use the first result
            manga_id = results[0]['manga_id']
            if not args.json:
                print(f"Using '{results[0]['title']}' (ID: {manga_id})")
    
    # Get manga details
    manga_details = get_manga_details(manga_id)
    
    if not manga_details:
        print(f"Manga ID {manga_id} not found")
        return 1
    
    # Get recommendations if not details-only
    recommendations = []
    if not args.details_only:
        recommendations = get_similar_manga(manga_id, args.num)
    
    # Output results
    if args.json:
        result = {
            "manga": manga_details,
            "recommendations": recommendations
        }
        print(json.dumps(result, default=str, indent=2))
    else:
        print("\n===== MANGA DETAILS =====")
        print(format_manga_info(manga_details))
        
        if not args.details_only:
            print("\n===== RECOMMENDATIONS =====")
            print(format_recommendations(recommendations))
    
    return 0

if __name__ == "__main__":
    sys.exit(main()) 