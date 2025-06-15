FROM ollama/ollama:latest

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY run.py /app/run.py
WORKDIR /app

EXPOSE 8080
EXPOSE 11434

CMD ["/entrypoint.sh"]
