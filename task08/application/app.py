import os
import redis
from flask import Flask

app = Flask(__name__)

REDIS_HOST = os.environ.get('REDIS_URL')
REDIS_PORT = int(os.environ.get('REDIS_PORT', 6380))
REDIS_PASSWORD = os.environ.get('REDIS_PWD')
REDIS_SSL = os.environ.get('REDIS_SSL_MODE', 'False') == 'True'

r = redis.StrictRedis(host=REDIS_HOST, port=REDIS_PORT, password=REDIS_PASSWORD, ssl=REDIS_SSL)

@app.route('/')
def hello():
    r.incr('visits')
    visits = r.get('visits').decode('utf-8')
    source = os.environ.get('CREATOR', 'Unknown')
    return f"Hello from {source}. Visits: {visits}"