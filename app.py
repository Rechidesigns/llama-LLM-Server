from langchain_ollama import ChatOllama
from langchain.schema import HumanMessage

import os
from fastapi import FastAPI
from dotenv import load_dotenv

load_dotenv()

app = FastAPI()

# Connect to the Ollama server
ollama_model = os.getenv("OLLAMA_MODEL", "llama3")
ollama_url = os.getenv("OLLAMA_URL")
llm = ChatOllama(model=ollama_model, base_url=ollama_url)

@app.post("/ask")
async def ask(prompt: str):
    response = await llm.agenerate([[HumanMessage(content=prompt)]])
    return {"response": response.generations[0][0].text}
