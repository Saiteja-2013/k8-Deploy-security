import os
from flask import Flask
import requests

app = Flask(__name__)

# Fetch DB credentials from environment variables
DB_USERNAME = os.getenv("DB_USERNAME")
DB_PASSWORD = os.getenv("DB_PASSWORD")

@app.route('/')
def home():
    return f'Hello, your database username is {DB_USERNAME}'

@app.route('/health')
def health_check():
    try:
        # Sample health check logic
        response = requests.get('http://example.com/health')
        if response.status_code == 200:
            return "Service is healthy", 200
        else:
            return "External service is down", 500
    except Exception as e:
        return f"Error: {str(e)}", 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

