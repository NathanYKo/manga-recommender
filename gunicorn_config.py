import multiprocessing
import os

port = os.environ.get("PORT", 8000)
bind = f"0.0.0.0:{port}"
# Reduce workers to avoid memory issues on Render free tier
workers = 2  # Fixed number instead of CPU-based calculation
worker_class = "sync"
worker_connections = 1000
timeout = 30
keepalive = 2 