from fastapi import FastAPI
from langchain_ollama import ChatOllama
from langchain.schema import HumanMessage
import os

app = FastAPI()

# Ollama is running inside the same container
OLLAMA_URL = "http://localhost:11434"
OLLAMA_MODEL = "llama3"

llm = ChatOllama(model=OLLAMA_MODEL, base_url=OLLAMA_URL)

@app.post("/ask")
async def ask(prompt: str):
    response = await llm.agenerate([[HumanMessage(content=prompt)]])
    text = response.generations[0][0].text
    return {"response": text}
