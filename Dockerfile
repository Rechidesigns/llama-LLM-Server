FROM python:3.11-slim

# Install dependencies
RUN apt-get update && apt-get install -y curl unzip netcat-openbsd && rm -rf /var/lib/apt/lists/*

# Install Ollama
RUN curl -fsSL https://ollama.com/download/ollama-linux-amd64.tgz -o ollama.tgz \
    && tar -xzf ollama.tgz -C /usr/local/bin \
    && rm ollama.tgz

# Install Python dependencies
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy app
COPY . .

# Make start script executable
RUN chmod +x /app/start.sh

EXPOSE 8000 11434

CMD ["/app/start.sh"]
