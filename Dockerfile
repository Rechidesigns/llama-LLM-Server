FROM python:3.11-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libpq-dev \
    gcc \
    curl \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Install Ollama CLI
RUN curl -sSL https://ollama.com/install.sh | bash

# Copy Python requirements
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the FastAPI app
COPY . .

# Expose both FastAPI and Ollama ports
EXPOSE 8000 11434

# Start Ollama server in the background, then start FastAPI
CMD ollama run llama3 --port 11434 & \
    uvicorn app:app --host 0.0.0.0 --port 8000
