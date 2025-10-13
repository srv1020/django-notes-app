# Use a lightweight Python base
FROM python:3.9-slim

# Set working directory
WORKDIR /app/backend

# Install system dependencies (only required ones)
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Copy only requirements first (to leverage Docker caching)
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Expose Django default port
EXPOSE 8000

# Default command (optional)
# CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
