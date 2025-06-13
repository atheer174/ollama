FROM ollama/ollama

# REMOVE this line (it breaks during build)
# RUN ollama pull granite-code

EXPOSE 11434
ENV OLLAMA_HOST=0.0.0.0:11434
CMD ["serve"]
