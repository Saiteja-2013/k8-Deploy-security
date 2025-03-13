# Dockerfile
FROM python:3.9

WORKDIR /app

# Copy application files
COPY . .

# Install dependencies
RUN pip install -r requirements.txt

# Security: Run as non-root user
RUN useradd -m appuser
USER appuser

# Use environment variables from Kubernetes secrets
CMD ["sh", "-c", "python app.py --db-user=$DB_USERNAME --db-pass=$DB_PASSWORD"]
