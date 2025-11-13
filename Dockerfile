# AsyncCypher Security Protocol (ASC) - Dockerfile
# ⚠️ DEMONSTRAÇÃO - NÃO USAR EM PRODUÇÃO

FROM node:18-alpine AS builder

# Metadados
LABEL maintainer="ASC Demo <demo@asc.local>"
LABEL description="AsyncCypher Security Protocol - API demonstrativa de segurança"
LABEL version="1.0.0"
LABEL security.warning="DEMONSTRAÇÃO - NÃO USAR EM PRODUÇÃO"

# Criar usuário não-root
RUN addgroup -g 1001 -S asc && \
    adduser -S asc -u 1001

# Diretório de trabalho
WORKDIR /app

# Copiar arquivos de dependências
COPY package*.json ./
COPY tsconfig.json ./

# Instalar dependências
RUN npm ci --only=production && \
    npm cache clean --force

# Copiar código fonte
COPY src/ ./src/

# Build da aplicação
RUN npm run build

# Estágio de produção
FROM node:18-alpine AS production

# Instalar dumb-init para gerenciamento de processos
RUN apk add --no-cache dumb-init

# Criar usuário não-root
RUN addgroup -g 1001 -S asc && \
    adduser -S asc -u 1001

# Diretório de trabalho
WORKDIR /app

# Copiar dependências de produção
COPY package*.json ./
RUN npm ci --only=production && \
    npm cache clean --force

# Copiar build da aplicação
COPY --from=builder /app/dist ./dist

# Criar diretórios necessários
RUN mkdir -p logs dados && \
    chown -R asc:asc /app

# Mudar para usuário não-root
USER asc

# Expor porta
EXPOSE 3000

# Variáveis de ambiente padrão
ENV NODE_ENV=production
ENV PORTA=3000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD node -e "require('http').get('http://localhost:3000/saude', (res) => { process.exit(res.statusCode === 200 ? 0 : 1) })"

# Comando de inicialização
ENTRYPOINT ["dumb-init", "--"]
CMD ["node", "dist/servidor.js"]