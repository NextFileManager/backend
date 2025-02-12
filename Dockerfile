FROM python:3.12-slim

# Set environment variables
ENV PYTHONPATH="${PYTHONPATH}:/app/app"

# Install required system dependencies
RUN apt-get update && apt-get install -y \
    libmagic1 file \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set environment variable for pip timeout
ENV PIP_DEFAULT_TIMEOUT=100

# Set working directory
WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt --index-url https://pypi.org/simple

# Copy fastapi code
COPY . .

# Expose backend port
EXPOSE 8000

# Run the app
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]