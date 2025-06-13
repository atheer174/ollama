FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install -y curl ca-certificates python3 && \
    curl -fsSL https://ollama.com/install.sh | sh && \
    apt-get clean

ENV PORT=8080
ENV OLLAMA_HOST=0.0.0.0:11434

EXPOSE 8080
EXPOSE 11434

CMD bash -c "ollama serve & \
             sleep 5 && \
             ollama pull granite-code && \
             python3 -m http.server 8080"
