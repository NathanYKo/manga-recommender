# utils/auth.py
import hashlib
import logging
import secrets
from datetime import datetime
from utils.helpers import execute_query

logger = logging.getLogger('manga_recommender.auth')

def hash_password(password, salt=None):
    """Hash a password with a salt for secure storage"""
    if salt is None:
        salt = secrets.token_hex(16)
    
    # Combine password and salt, then hash
    password_hash = hashlib.sha256((password + salt).encode()).hexdigest()
    
    return password_hash, salt

def verify_password(password, stored_hash, salt):
    """Verify a password against a stored hash"""
    # Hash the provided password with the same salt
    password_hash, _ = hash_password(password, salt)
    
    # Compare the hashes
    return password_hash == stored_hash

def get_user(username=None, user_id=None):
    """Get user by username or user_id"""
    if username:
        query = "SELECT * FROM users WHERE username = %s"
        params = (username,)
    elif user_id:
        query = "SELECT * FROM users WHERE user_id = %s"
        params = (user_id,)
    else:
        return None
    
    try:
        result = execute_query(query, params)
        if result and len(result) > 0:
            return result[0]
        return None
    except Exception as e:
        logger.error(f"Error getting user: {e}")
        return None

def create_user(username, password, email=None):
    """Create a new user"""
    # Check if username already exists
    if get_user(username=username):
        return False, "Username already exists"
    
    # Hash the password
    password_hash, salt = hash_password(password)
    
    # Insert the new user
    query = """
    INSERT INTO users (username, password_hash, salt, email, created_at)
    VALUES (%s, %s, %s, %s, %s)
    RETURNING user_id
    """
    
    try:
        now = datetime.now()
        result = execute_query(query, (username, password_hash, salt, email, now))
        
        if result and len(result) > 0:
            return True, result[0]['user_id']
        return False, "Failed to create user"
    except Exception as e:
        logger.error(f"Error creating user: {e}")
        return False, str(e)