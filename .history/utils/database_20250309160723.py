import psycopg2
import psycopg2.extras
from psycopg2.pool import SimpleConnectionPool
from contextlib import contextmanager
from utils.config import config

class DatabaseManager:
    _pool = None

    @classmethod
    def initialize(cls):
        if cls._pool is None:
            import logging
            logger = logging.getLogger('manga_recommender.database')
            
            # Use get_db_config() instead of get('database')
            db_config = config.get_db_config()
            logger.info(f"Initializing database connection pool with: host={db_config.get('host')}, user={db_config.get('user')}, database={db_config.get('database')}")
            
            # Only include non-empty parameters
            connect_params = {}
            if 'host' in db_config and db_config['host']:
                connect_params['host'] = db_config['host']
            if 'port' in db_config and db_config['port']:
                connect_params['port'] = db_config['port']
            if 'database' in db_config and db_config['database']:
                connect_params['dbname'] = db_config['database']
            if 'user' in db_config and db_config['user']:
                connect_params['user'] = db_config['user']
            if 'password' in db_config and db_config['password']:
                connect_params['password'] = db_config['password']
            
            # Add required connection pool parameters
            connect_params['minconn'] = 1
            connect_params['maxconn'] = 20
            
            try:
                logger.info(f"Connection parameters: {str({k: '****' if k == 'password' else v for k, v in connect_params.items()})}")
                cls._pool = SimpleConnectionPool(**connect_params)
                logger.info("Database connection pool initialized successfully")
            except Exception as e:
                logger.error(f"Error initializing database connection pool: {e}")
                raise

    @classmethod
    @contextmanager
    def get_connection(cls):
        if cls._pool is None:
            cls.initialize()
        
        conn = cls._pool.getconn()
        try:
            yield conn
        finally:
            cls._pool.putconn(conn)

    @classmethod
    def execute_query(cls, query, params=None, fetch_one=False):
        with cls.get_connection() as conn:
            with conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor) as cur:
                cur.execute(query, params)
                if query.strip().upper().startswith('SELECT'):
                    return cur.fetchone() if fetch_one else cur.fetchall()
                conn.commit()
                return None

    @classmethod
    def execute_batch(cls, query, params_list):
        with cls.get_connection() as conn:
            with conn.cursor() as cur:
                psycopg2.extras.execute_batch(cur, query, params_list)
                conn.commit() 