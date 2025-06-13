FROM ubuntu:20.04

# Install Ollama and dependencies
RUN apt-get update && \
    apt-get install -y curl ca-certificates python3 && \
    curl -fsSL https://ollama.com/install.sh | sh && \
    apt-get clean

# Set the environment for Ollama and dummy HTTP server
ENV OLLAMA_HOST=0.0.0.0:11434
ENV PORT=8080

EXPOSE 8080
EXPOSE 11434

# Start Ollama and a simple HTTP server on 8080 for Code Engine's health check
CMD bash -c "ollama serve & \
             sleep 5 && \
             ollama pull granite-code && \
             python3 -m http.server 8080"
