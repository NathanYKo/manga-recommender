import psycopg2
from psycopg2.pool import SimpleConnectionPool
from contextlib import contextmanager
from utils.config import config

class DatabaseManager:
    _pool = None

    @classmethod
    def initialize(cls):
        if cls._pool is None:
            db_config = config.get('database')
            cls._pool = SimpleConnectionPool(
                minconn=1,
                maxconn=20,
                host=db_config['host'],
                port=db_config['port'],
                database=db_config['database'],
                user=db_config['user'],
                password=db_config['password']
            )

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