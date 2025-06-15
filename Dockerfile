FROM ollama/ollama:latest

# Install Python and dependencies
RUN apt-get update && \
    apt-get install -y python3-pip && \
    pip3 install fastapi uvicorn httpx

# Copy your app and entrypoint script
COPY run.py /app/run.py
COPY entrypoint.sh /app/entrypoint.sh
WORKDIR /app

RUN chmod +x entrypoint.sh

EXPOSE 8080

CMD ["./entrypoint.sh"]
