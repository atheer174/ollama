FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install -y curl ca-certificates python3 python3-pip && \
    curl -fsSL https://ollama.com/install.sh | sh && \
    pip3 install fastapi uvicorn && \
    apt-get clean

ENV PORT=8080
ENV OLLAMA_HOST=0.0.0.0:11434
ENV OLLAMA_MODEL=mistral

EXPOSE 8080
EXPOSE 11434

COPY run.py /app/run.py
WORKDIR /app

CMD bash -c "ollama serve & sleep 4 && ollama pull $OLLAMA_MODEL && uvicorn run:app --host 0.0.0.0 --port $PORT"
