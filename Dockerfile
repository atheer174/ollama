FROM ubuntu:20.04

# Install Ollama
RUN apt-get update && apt-get install -y curl ca-certificates && \
    curl -fsSL https://ollama.com/install.sh | sh && \
    apt-get clean

# Fallback if PORT is not injected
ENV PORT=8080
ENV OLLAMA_HOST=0.0.0.0:${PORT}

EXPOSE 8080

CMD ["ollama", "serve"]
