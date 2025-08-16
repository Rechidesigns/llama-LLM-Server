from fastapi import FastAPI, Query
from langchain_ollama import ChatOllama
from langchain.schema import HumanMessage
import os

app = FastAPI()

OLLAMA_URL = os.getenv("OLLAMA_URL", "http://localhost:11434")
llm = ChatOllama(model="llama3", base_url=OLLAMA_URL)

@app.post("/ask")
async def ask(prompt: str = Query(..., description="Prompt to send to Llama")):
    response = await llm.agenerate([[HumanMessage(content=prompt)]])
    return {"response": response.generations[0][0].text}
