#!/bin/bash
set -e

# Start Ollama in the background
ollama serve &
echo "Starting Ollama server..."

# Wait for Ollama to be ready
until nc -z localhost 11434; do
  echo "Waiting for Ollama to start..."
  sleep 1
done

# (Optional) preload the llama3 model
ollama run llama3 --prompt "Hello" || true

# Start FastAPI app
echo "Starting FastAPI app..."
exec uvicorn app:app --host 0.0.0.0 --port 8000
