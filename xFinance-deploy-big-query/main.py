
from fastapi import FastAPI
import os

app = FastAPI()

@app.get("/")
def read_root():
    token = os.getenv("API_TOKEN")
    return {"message": "API rodando com sucesso!", "token_configurado": token is not None}
