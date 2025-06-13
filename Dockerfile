# Base image with Ollama pre-installed
FROM ollama/ollama

# Optional: Pre-pull the Granite model (will increase image size)
RUN ollama pull granite-code

# Expose the Ollama API port
EXPOSE 11434

# Ensure Ollama listens on all interfaces (important for Code Engine)
ENV OLLAMA_HOST=0.0.0.0:11434

# Start Ollama server
CMD ["serve"]
