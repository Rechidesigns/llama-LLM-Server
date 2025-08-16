from fastapi import FastAPI
from langchain_ollama import ChatOllama
import os
from dotenv import load_dotenv

load_dotenv()

app = FastAPI()

# Initialize the Ollama LLM client
ollama_model = os.getenv("OLLAMA_MODEL", "llama3")
llm = ChatOllama(model=ollama_model)

@app.post("/generate")
def generate(prompt: str):
    # Send prompt to the Ollama model
    response = llm(prompt)
    return {"text": response}
