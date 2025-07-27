#!/bin/bash

echo "🚀 Iniciando setup do backend Vivere (v2)..."

# Python
echo -e "\n🐍 Verificando Python..."
command -v python3 >/dev/null || sudo apt install -y python3
python3 --version

# pip & pipx
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

# Node + npm
echo -e "\n🌐 Verificando Node.js e NPM..."
command -v node >/dev/null || curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - && sudo apt install -y nodejs
node -v && npm -v

# Supabase CLI via binário
echo -e "\n🛠 Verificando Supabase CLI..."
if ! command -v supabase >/dev/null; then
  echo "⬇️ Instalando Supabase CLI via binário..."
  curl -sL https://github.com/supabase/cli/releases/latest/download/supabase_linux_amd64.tar.gz | tar -xz
  chmod +x supabase
  sudo mv supabase /usr/local/bin
fi
supabase --version

# Docker
echo -e "\n🐳 Verificando Docker..."
command -v docker >/dev/null || (curl -fsSL https://get.docker.com | sh && sudo usermod -aG docker $USER)
docker --version

# Docker Compose
echo -e "\n📦 Verificando Docker Compose..."
if command -v docker-compose >/dev/null; then
  docker-compose --version
elif docker compose version &>/dev/null; then
  docker compose version
else
  echo "⚠️ Docker Compose não encontrado. Tentando instalar..."
  sudo apt install -y docker-compose
fi

# Just
echo -e "\n🧃 Verificando Just..."
command -v just >/dev/null || sudo snap install --edge --classic just
just --version

# Zsh
echo -e "\n💡 Verificando Zsh..."
command -v zsh >/dev/null || sudo apt install -y zsh

echo -e "\n🎉 Setup finalizado com sucesso!"
echo "✅ Ambiente backend Vivere pronto pra codar com segurança e cafeína ☕"
