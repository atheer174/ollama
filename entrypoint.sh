#!/bin/bash
set -e

MODEL="${OLLAMA_MODEL:-mistral-small:latest}"
PORT=11434

# Start Ollama in background on a temporary port
/bin/ollama serve --port 11223 &
pid=$!

# Wait up to 60s for Ollama to be ready
for i in $(seq 1 30); do
  if curl -s http://localhost:11223 | grep -q "Ollama is running"; then
    break
  fi
  sleep 2
done

# Pull the model via the running Ollama service
OLLAMA_HOST=localhost:11223 /bin/ollama pull "$MODEL"

# Shutdown temporary Ollama server
kill $pid && wait $pid 2>/dev/null || true

# Finally, start real Ollama service with the pulled model
export OLLAMA_HOST="0.0.0.0:$PORT"
/bin/ollama serve --port $PORT
