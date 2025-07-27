#!/bin/bash

echo "🚀 Iniciando setup do backend Vivere..."

# Python
echo -e "\n🐍 Verificando Python..."
command -v python3 >/dev/null || sudo apt install -y python3
python3 --version

echo -e "\n📦 Verificando pip e pipx..."
command -v pip3 >/dev/null || sudo apt install -y python3-pip
command -v pipx >/dev/null || python3 -m pip install --user pipx && python3 -m pipx ensurepath
pip3 --version && pipx --version

# FastAPI
echo -e "\n⚙️ Verificando FastAPI..."
pipx list | grep fastapi || pipx install fastapi

# Uvicorn
echo -e "\n⚙️ Verificando Uvicorn..."
pipx list | grep uvicorn || pipx install uvicorn

# Node + NPM
echo -e "\n🌐 Verificando Node.js e NPM..."
command -v node >/dev/null || curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - && sudo apt install -y nodejs
node -v && npm -v

# Supabase CLI
echo -e "\n🛠 Verificando Supabase CLI..."
command -v supabase >/dev/null || npm install -g supabase
supabase --version

# Docker
echo -e "\n🐳 Verificando Docker..."
command -v docker >/dev/null || (curl -fsSL https://get.docker.com | sh && sudo usermod -aG docker $USER)
docker --version

# Docker Compose
echo -e "\n📦 Verificando Docker Compose..."
docker compose version || echo "⚠️ Docker Compose não encontrado — pode precisar atualizar o Docker Desktop."

# Just (task runner)
echo -e "\n🧃 Verificando Just..."
command -v just >/dev/null || sudo snap install --edge --classic just
just --version

# Zsh + Oh My Zsh (opcional)
echo -e "\n💡 Verificando Zsh..."
command -v zsh >/dev/null || sudo apt install -y zsh

echo -e "\n🎉 Setup finalizado com sucesso!"
echo "✅ Ambiente backend Vivere pronto pra codar! Execute 'just backend-dev' ou equivalente pra iniciar o servidor."

