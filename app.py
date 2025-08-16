from fastapi import FastAPI
from llama_cpp import Llama
import os
from dotenv import load_dotenv

load_dotenv()

app = FastAPI()
model_path = os.getenv("LLAMA_MODEL_PATH", "models/llama-13b/ggml-model.bin")
llm = Llama(model_path=model_path)

@app.post("/generate")
def generate(prompt: str):
    output = llm(prompt, max_tokens=512)
    return {"text": output["choices"][0]["text"]}
