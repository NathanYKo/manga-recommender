import os
import subprocess
from datetime import datetime
from utils.config import config

def backup_database():
    db_config = config.get_db_config()
    timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
    backup_path = f"backups/manga_db_{timestamp}.sql"
    
    # Ensure backup directory exists
    os.makedirs('backups', exist_ok=True)
    
    # Create backup command
    cmd = [
        'pg_dump',
        f"-h{db_config['host']}",
        f"-p{db_config['port']}",
        f"-U{db_config['user']}",
        f"-d{db_config['database']}",
        f"-f{backup_path}"
    ]
    
    try:
        subprocess.run(cmd, env={'PGPASSWORD': db_config['password']}, check=True)
        return f"Backup created successfully: {backup_path}"
    except subprocess.CalledProcessError as e:
        return f"Backup failed: {str(e)}" 