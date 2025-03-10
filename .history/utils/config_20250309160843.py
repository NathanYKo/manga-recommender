# utils/config.py
import configparser
import os
import logging

# Configure logging
logger = logging.getLogger('manga_recommender.config')

# Load configuration from config.ini file
config = {}

def load_config():
    global config
    
    # First try to load from environment variables
    database_url = os.environ.get('DATABASE_URL')
    if database_url:
        # Parse the database URL to get components
        # Format: postgres://user:password@host:port/dbname
        config['database'] = {}
        
        # Remove postgres:// prefix
        db_info = database_url.replace('postgres://', '')
        
        # Split into auth and connection parts
        auth, connection = db_info.split('@', 1)
        
        # Get username and password
        if ':' in auth:
            username, password = auth.split(':', 1)
            config['database']['user'] = username
            config['database']['password'] = password
        else:
            # If no password in the URL, just use the auth part as username
            config['database']['user'] = auth
            config['database']['password'] = ''  # Empty password
        
        # Get host, port, and database name
        if '/' in connection:
            host_port, dbname = connection.split('/', 1)
            config['database']['database'] = dbname
            
            if ':' in host_port:
                host, port = host_port.split(':', 1)
                config['database']['host'] = host
                config['database']['port'] = port
            else:
                config['database']['host'] = host_port
        
        logger.info("Loaded database configuration from environment variables")
    else:
        # Fall back to config.ini
        try:
            parser = configparser.ConfigParser()
            parser.read('config.ini')
            
            for section in parser.sections():
                config[section.lower()] = {}
                for key, value in parser.items(section):
                    config[section.lower()][key] = value
            
            logger.info("Loaded configuration from config.ini")
        except Exception as e:
            logger.error(f"Error loading configuration: {e}")
            # Set default values
            config = {
                'database': {
                    'host': 'localhost',
                    'port': '5432',
                    'database': 'manga_recommender',
                    'user': 'postgres',
                    'password': ''
                }
            }
    
    return config

# Load configuration on import
config = load_config()

class Config:
    _instance = None
    
    def __new__(cls):
        if cls._instance is None:
            cls._instance = super(Config, cls).__new__(cls)
            cls._instance._load_config()
        return cls._instance
    
    def _load_config(self):
        self.config = configparser.ConfigParser()
        config_path = os.path.join(os.path.dirname(os.path.dirname(__file__)), 'config.ini')
        self.config.read(config_path)
    
    def get_api_config(self):
        return dict(self.config['API'])
    
    def get_db_config(self):
        # First check for DATABASE_URL environment variable
        database_url = os.environ.get('DATABASE_URL')
        if database_url:
            # Parse the database URL into components
            db_config = {}
            
            # Handle postgres:// vs postgresql:// prefix
            if database_url.startswith('postgresql://'):
                db_info = database_url[len('postgresql://'):]
            elif database_url.startswith('postgres://'):
                db_info = database_url[len('postgres://'):]
            else:
                # Assume it's already without prefix
                db_info = database_url
            
            # Log the URL being processed (with masked password if any)
            safe_url = database_url
            if '@' in database_url and ':' in database_url.split('@')[0]:
                auth, rest = database_url.split('@', 1)
                if ':' in auth:
                    # URL format is like: postgresql://username:password@host/db
                    proto_user, pwd = auth.rsplit(':', 1)
                    safe_url = f"{proto_user}:****@{rest}"
            logger.info(f"Processing database URL: {safe_url}")
            
            # Split into auth and connection parts
            if '@' in db_info:
                auth, connection = db_info.split('@', 1)
                
                # If auth still contains protocol, remove it
                if '://' in auth:
                    auth = auth.split('://', 1)[1]
                
                # Extract username and password
                if ':' in auth:
                    username, password = auth.split(':', 1)
                    db_config['user'] = username
                    db_config['password'] = password
                else:
                    db_config['user'] = auth
                    db_config['password'] = ''
                
                # Extract host, port, and database name
                if '/' in connection:
                    host_port, dbname = connection.split('/', 1)
                    db_config['database'] = dbname
                    
                    if ':' in host_port:
                        host, port = host_port.split(':', 1)
                        db_config['host'] = host
                        db_config['port'] = port
                    else:
                        db_config['host'] = host_port
                        db_config['port'] = '5432'  # Default PostgreSQL port
            else:
                # If there's no @ in the URL, it might be a simple connection string
                logger.warning(f"Database URL format not recognized: {safe_url}")
            
            logger.info(f"Parsed database config: host={db_config.get('host')}, user={db_config.get('user')}, database={db_config.get('database')}")
            return db_config
        
        # Fall back to config.ini
        return dict(self.config['Database'])
    
    def get_web_config(self):
        return dict(self.config['Web'])

config = Config()