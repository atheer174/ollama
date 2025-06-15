#!/bin/bash

# Start ollama server in background
ollama serve &

# Wait for ollama server to be ready
until curl -s http://localhost:11434 > /dev/null; do
  echo "Waiting for Ollama to start..."
  sleep 1
done

# Pull the model
ollama pull mistral-small:latest

# Start FastAPI app
uvicorn run:app --host 0.0.0.0 --port 8080
