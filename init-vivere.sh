#!/bin/bash

echo "🧱 Criando estrutura de diretórios do Vivere..."

mkdir -p backend/app mobile web-dashboard .github/workflows

echo "📄 Criando arquivos base..."

# README.md
cat <<EOF > README.md
# 🧠 Vivere – Super App de Saúde Mental & Redução de Vícios

> MVP brasileiro para prevenir crises de ansiedade e ajudar na cessação de vícios como álcool, cigarro e redes sociais. Usando IA, gamificação e psicólogos em um único app.

## 📦 Tecnologias

- **Mobile:** React Native + Expo
- **Web Dashboard:** Next.js
- **Backend:** FastAPI
- **Banco:** Supabase (PostgreSQL)
- **IA:** OpenAI (créditos gratuitos) ou LLM local via Ollama
- **Vídeo:** Jitsi Público

## 🚀 Rodando localmente

\`\`\`bash
git clone https://github.com/vanzer80/Vivere.git
cd Vivere
docker-compose up --build
\`\`\`

## 🔐 Variáveis de ambiente

Veja \`.env.example\` para configurar \`SUPABASE_URL\`, \`OPENAI_API_KEY\` etc.

## 📄 Licença

MIT © 2025 Luis Vanzer
EOF

# .gitignore
cat <<EOF > .gitignore
__pycache__/
*.pyc
node_modules/
.env
.env.*
.expo/
.expo-shared/
.vscode/
.idea/
dist/
build/
EOF

# .env.example
cat <<EOF > .env.example
SUPABASE_URL=https://xxx.supabase.co
SUPABASE_ANON_KEY=your-anon-key
SUPABASE_SERVICE_ROLE=your-service-role
OPENAI_API_KEY=sk-xxx
JITSI_SERVER_URL=https://meet.jit.si
EOF

# docker-compose.yml
cat <<EOF > docker-compose.yml
version: "3.9"

services:
  backend:
    build: ./backend
    volumes:
      - ./backend:/app
    ports:
      - "8000:8000"
    env_file:
      - .env
EOF

# backend/requirements.txt
cat <<EOF > backend/requirements.txt
fastapi
uvicorn
python-dotenv
openai
supabase
EOF

# backend/app/main.py
cat <<EOF > backend/app/main.py
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
EOF

# backend/Dockerfile
cat <<EOF > backend/Dockerfile
FROM python:3.10-slim

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY app ./app

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
EOF

# CI/CD GitHub Actions
cat <<EOF > .github/workflows/ci.yml
name: CI

on:
  push:
    branches: [ main, feat/* ]
  pull_request:
    branches: [ main ]

jobs:
  build-backend:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout Repo
      uses: actions/checkout@v3

    - name: Setup Python
      uses: actions/setup-python@v4
      with:
        python-version: "3.10"

    - name: Install Dependencies
      run: |
        cd backend
        pip install -r requirements.txt

    - name: Run FastAPI Check
      run: |
        cd backend
        python -m compileall app
EOF

echo "✅ Estrutura do projeto criada com sucesso!"
