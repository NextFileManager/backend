FROM python:3.12-slim

# Set environment variable for pip timeout
ENV PIP_DEFAULT_TIMEOUT=100

# RUN apt-get update && apt-get install -y \
#     build-essential \
#     gcc \
#     libgfortran5

# Set working directory
WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt --index-url https://pypi.org/simple

# Copy fastapi code
COPY ./app .

# Expose backend port
EXPOSE 8000

# Run the app
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]

