FROM ollama/ollama

# Code Engine sets $PORT to what it expects your app to use
ENV OLLAMA_HOST=0.0.0.0:${PORT}

EXPOSE 8080
CMD ["serve"]
