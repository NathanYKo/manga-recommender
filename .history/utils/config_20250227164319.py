# utils/config.py
import configparser
import os

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
        return dict(self.config['Database'])
    
    def get_web_config(self):
        return dict(self.config['Web'])

config = Config()