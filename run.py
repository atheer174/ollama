import os, json, asyncio, subprocess
from fastapi import FastAPI, Request
from fastapi.responses import StreamingResponse, JSONResponse
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()
app.add_middleware(CORSMiddleware, allow_origins=["*"], allow_methods=["*"], allow_headers=["*"])
MODEL = os.getenv("OLLAMA_MODEL", "mistral-small:latest")

@app.post("/v1/chat/completions")
async def chat(request: Request):
    body = await request.json()
    messages = body.get("messages", [])
    prompt = "\n".join([m["content"] for m in messages])
    stream = body.get("stream", False)

    if not stream:
        proc = subprocess.run(["ollama", "run", MODEL, prompt], capture_output=True, text=True)
        return {"choices":[{"message":{"content":proc.stdout.strip()}}]}

    async def gen():
        proc = await asyncio.create_subprocess_exec(
            "ollama", "run", MODEL, "--stream", prompt,
            stdout=asyncio.subprocess.PIPE, stderr=asyncio.subprocess.PIPE
        )
        yield f"data: {json.dumps({'choices':[{'delta':{'role':'assistant'}}]})}\n\n"
        while True:
            line = await proc.stdout.readline()
            if not line:
                break
            chunk = line.decode().strip()
            yield f"data: {json.dumps({'choices':[{'delta':{'content':chunk}}]})}\n\n"
        yield "data: [DONE]\n\n"

    return StreamingResponse(gen(), media_type="text/event-stream")
