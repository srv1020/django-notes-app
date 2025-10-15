# Use a lightweight Python base
FROM python:3.9-slim

# Set working directory
WORKDIR /app/backend

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc default-libmysqlclient-dev pkg-config curl \
    && rm -rf /var/lib/apt/lists/*

# Copy only requirements first (to leverage Docker caching)
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Download wait-for-it.sh
RUN curl -o /app/backend/wait-for-it.sh https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh \
    && chmod +x /app/backend/wait-for-it.sh

# Expose Django default port
EXPOSE 8000

# Default command (optional, can be overridden in docker-compose)
CMD ["gunicorn", "notesapp.wsgi", "--bind", "0.0.0.0:8000"]
