FROM ollama/ollama:latest

RUN ollama pull mistral-small:latest

COPY run.py /app/run.py
WORKDIR /app

EXPOSE 8080

CMD ["uvicorn", "run:app", "--host", "0.0.0.0", "--port", "8080"]
