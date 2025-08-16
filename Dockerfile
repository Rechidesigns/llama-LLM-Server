FROM python:3.11-slim

WORKDIR /app

# Install dependencies
RUN apt-get update && apt-get install -y curl unzip

# Install Ollama
RUN curl -sSL https://ollama.com/install.sh | bash

# Copy requirements and install Python deps
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy code
COPY . .

# Expose ports
EXPOSE 8000 11434

# Start Ollama in background, then FastAPI
CMD sh -c "ollama run llama3 & uvicorn app:app --host 0.0.0.0 --port 8000"
