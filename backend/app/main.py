from fastapi import FastAPI
import os

app = FastAPI()

@app.get("/")
def read_root():
    return {
        "message": "🚀 Vivere Backend Ativo!",
        "supabase_url": os.getenv("SUPABASE_URL"),
        "jitsi": os.getenv("JITSI_SERVER_URL")
    }
