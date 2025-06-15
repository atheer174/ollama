FROM ollama/ollama:latest

# Pull the model through CLI at build time
RUN ollama pull mistral-small:latest

# Copy wrapper and entrypoint
COPY run.py /app/run.py
WORKDIR /app

EXPOSE 8080

# Use uvicorn to serve FastAPI on the correct PORT
CMD ["uvicorn", "run:app", "--host", "0.0.0.0", "--port", "8080"]
