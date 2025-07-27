# justfile – Comandos do projeto Vivere

# Setup inicial do app mobile com Expo
mobile:
	cd mobile && chmod +x init-mobile.sh && ./init-mobile.sh

# Roda o backend local com Docker Compose
backend:
	cd backend && docker-compose up --build

# Roda o app mobile (Expo)
dev-mobile:
	cd mobile && npx expo start

# Executa os testes do backend com pytest
test-backend:
	cd backend && pytest

# Executa ESLint no app mobile
lint-mobile:
	cd mobile && npx eslint .

# Build do app mobile (modo produção, via EAS ou Expo)
build-mobile:
	cd mobile && npx expo export

# Substitui GitHub Actions / CI futuramente
ci:
	echo "🛠️ CI local em construção... em breve via GitHub Actions"

# Mostra comandos disponíveis
default:
	@echo "🧪 Comandos disponíveis no projeto Vivere:"
	@just --summary
