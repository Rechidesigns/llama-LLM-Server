#!/bin/sh

# Start Ollama in background
nohup ollama run llama3 &

# Wait for Ollama to start
until nc -z localhost 11434; do
  echo "Waiting for Ollama to start..."
  sleep 1
done

echo "Ollama is up! Starting FastAPI..."

# Start FastAPI
uvicorn app:app --host 0.0.0.0 --port 8000
