from flask import Flask
import os
import redis
from datetime import datetime

app = Flask(__name__)

# Redis configuration
redis_url = os.getenv('REDIS_URL', 'localhost')
redis_port = int(os.getenv('REDIS_PORT', 6379))
redis_password = os.getenv('REDIS_PWD', None)
redis_ssl = os.getenv('REDIS_SSL_MODE', 'False').lower() == 'true'

if redis_password:
    redis_client = redis.Redis(
        host=redis_url,
        port=redis_port,
        password=redis_password,
        ssl=redis_ssl,
        ssl_cert_reqs=None
    )
else:
    redis_client = redis.Redis(
        host=redis_url,
        port=redis_port,
        ssl=redis_ssl,
        ssl_cert_reqs=None
    )

@app.route('/')
def hello():
    creator = os.getenv('CREATOR', 'WebAPP')
    
    # Increment visit count
    try:
        visits = redis_client.incr('counter')
    except redis.RedisError:
        visits = 0
    
    return f'''
    Hello from {creator}!<br/><br/>
    <strong>Hostname:</strong> {os.getenv('HOSTNAME', 'unknown')}<br/>
    <strong>Visits:</strong> {visits}
    '''

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)