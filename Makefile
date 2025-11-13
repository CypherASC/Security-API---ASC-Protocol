# AsyncCypher Security Protocol (ASC) - Makefile

.PHONY: help install setup dev build start test lint clean docs

# Variáveis
NODE_VERSION := 18
NPM := npm

help: ## Mostrar ajuda
	@echo "AsyncCypher Security Protocol (ASC) - Comandos Disponíveis:"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
	@echo ""
	@echo "⚠️  DEMONSTRAÇÃO - NÃO USAR EM PRODUÇÃO"

install: ## Instalar dependências
	@echo "📦 Instalando dependências..."
	$(NPM) install
	@echo "✅ Dependências instaladas"

setup: install ## Configuração inicial completa
	@echo "🔧 Configuração inicial do ASC..."
	$(NPM) run gerar-chaves
	$(NPM) run inicializar
	@echo "✅ Configuração concluída"

dev: ## Iniciar servidor em modo desenvolvimento
	@echo "🚀 Iniciando servidor de desenvolvimento..."
	$(NPM) run dev

build: ## Build para produção
	@echo "🏗️  Fazendo build..."
	$(NPM) run build
	@echo "✅ Build concluído"

start: build ## Iniciar servidor em produção
	@echo "🚀 Iniciando servidor de produção..."
	$(NPM) start

test: ## Executar testes
	@echo "🧪 Executando testes..."
	$(NPM) test

test-watch: ## Executar testes em modo watch
	@echo "🧪 Executando testes em modo watch..."
	$(NPM) run test:watch

lint: ## Verificar código com linter
	@echo "🔍 Verificando código..."
	$(NPM) run lint

lint-fix: ## Corrigir problemas de linting
	@echo "🔧 Corrigindo problemas de linting..."
	$(NPM) run lint:fix

format: ## Formatar código
	@echo "💅 Formatando código..."
	$(NPM) run format

clean: ## Limpar arquivos gerados
	@echo "🧹 Limpando arquivos..."
	rm -rf dist/
	rm -rf node_modules/
	rm -rf coverage/
	rm -rf logs/
	rm -rf dados/
	rm -f .env
	@echo "✅ Limpeza concluída"

reset: clean setup ## Reset completo do projeto
	@echo "🔄 Reset completo realizado"

docs: ## Abrir documentação
	@echo "📚 Abrindo documentação..."
	@echo "Swagger UI: http://localhost:3000/docs"
	@echo "Documentação: ./docs/"

security-check: ## Verificar vulnerabilidades
	@echo "🔒 Verificando vulnerabilidades..."
	$(NPM) audit
	$(NPM) audit fix

logs: ## Visualizar logs
	@echo "📋 Logs do sistema:"
	@if [ -f logs/asc.log ]; then tail -f logs/asc.log; else echo "Nenhum log encontrado"; fi

status: ## Status do sistema
	@echo "📊 Status do ASC:"
	@curl -s http://localhost:3000/saude | jq . || echo "Servidor não está rodando"

demo: ## Executar demonstração completa
	@echo "🎭 Executando demonstração..."
	@echo "1. Verificando saúde do servidor..."
	@curl -s http://localhost:3000/saude || echo "Inicie o servidor com 'make dev'"
	@echo ""
	@echo "2. Registrando usuário demo..."
	@curl -X POST http://localhost:3000/auth/registrar \
		-H "Content-Type: application/json" \
		-d '{"email":"demo@asc.test","senha":"Demo@123","nome":"Usuário Demo"}' \
		-s | jq .
	@echo ""
	@echo "3. Fazendo login..."
	@curl -X POST http://localhost:3000/auth/login \
		-H "Content-Type: application/json" \
		-d '{"email":"demo@asc.test","senha":"Demo@123"}' \
		-s | jq .

docker-build: ## Build da imagem Docker
	@echo "🐳 Construindo imagem Docker..."
	docker build -t asc-demo .

docker-run: ## Executar container Docker
	@echo "🐳 Executando container..."
	docker run -p 3000:3000 --env-file .env asc-demo

# Comandos de desenvolvimento
dev-setup: ## Setup para desenvolvimento
	@echo "👨‍💻 Configurando ambiente de desenvolvimento..."
	$(NPM) install
	$(NPM) run gerar-chaves
	@echo "✅ Ambiente de desenvolvimento pronto"

dev-reset: ## Reset do ambiente de desenvolvimento
	@echo "🔄 Resetando ambiente de desenvolvimento..."
	rm -rf dados/
	rm -rf logs/
	$(NPM) run gerar-chaves
	$(NPM) run inicializar
	@echo "✅ Ambiente resetado"

# Comandos de produção (NÃO USAR - APENAS DEMO)
prod-check: ## Verificações para produção (DEMO)
	@echo "⚠️  VERIFICAÇÕES DE PRODUÇÃO (DEMONSTRAÇÃO):"
	@echo "❌ Chaves em variáveis de ambiente"
	@echo "❌ Sem HSM/KMS"
	@echo "❌ Sem auditoria de segurança"
	@echo "❌ Logs básicos apenas"
	@echo "❌ Sem monitoramento avançado"
	@echo ""
	@echo "🚨 NÃO USE EM PRODUÇÃO SEM AUDITORIA COMPLETA!"

# Default target
.DEFAULT_GOAL := help