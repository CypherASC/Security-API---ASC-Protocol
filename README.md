# AsyncCypher Security Protocol (ASC)

⚠️ **DEMONSTRAÇÃO — NÃO UTILIZAR EM PRODUÇÃO** ⚠️

> Este projeto destina-se **exclusivamente** a fins educacionais e demonstrativos.
> **Não utilize em ambientes de produção** sem auditoria de segurança profissional e medidas adicionais.

---

## Avisos Importantes

### Por que NÃO usar em produção?

- Segredos armazenados em variáveis de ambiente locais
- Ausência de HSM (Hardware Security Module) e KMS
- Falta de auditoria de segurança profissional
- Implementação simplificada e adaptada para demonstração
- Inexistência de monitoramento e alertas avançados
- Configurações e recomendações não otimizadas para produção

---

## Sobre o Projeto

O **AsyncCypher Security Protocol (ASC)** é uma API demonstrativa, desenvolvida com Node.js, TypeScript e Express, implementando práticas modernas de criptografia e segurança.

### Funcionalidades Demonstradas

- Autenticação JWT com refresh tokens e rotação segura
- Criptografia simétrica (AES-256-GCM) e assimétrica (RSA-4096)
- Hash de senhas seguro (Argon2id)
- Controle de acesso baseado em roles (usuário/admin)
- Validação robusta de entradas (Joi)
- Proteção contra ataques de força bruta (Rate limiting)
- Configuração de CORS e headers de segurança (Helmet)
- Logs e monitoramento de eventos de segurança

---

## Stack Tecnológica

- **Node.js** + **TypeScript** + **Express**  
  - Ecossistema maduro de bibliotecas de segurança
  - Performance otimizada para APIs
  - Tipagem estática para maior segurança em tempo de desenvolvimento
  - Facilidade de implementação de middlewares e integrações
  - Comunidade ativa e ampla documentação

---

## Estrutura do Projeto

```
src/
├── controladores/    # Controllers da API
├── servicos/         # Lógica de negócio
├── middlewares/      # Middlewares de segurança
├── modelos/          # Modelos de dados
├── rotas/            # Definição das rotas
└── utilitarios/      # Funções utilitárias
testes/               # Testes unitários e integração
config/               # Arquivos de configuração
scripts/              # Scripts auxiliares
docs/                 # Documentação adicional
```

---

## Instalação e Execução

> **Pré-requisitos:**  
> - Node.js 18+
> - npm ou yarn

### 1. Instale as dependências

```sh
npm install
# ou
yarn install
```

### 2. Configuração rápida (DEMONSTRAÇÃO)

> O projeto inclui chaves de demonstração pré-configuradas. Não utilize em ambientes reais!

```sh
npm run dev
```

### 3. Gerar suas próprias chaves (RECOMENDADO)

```sh
cp .env.exemplo .env
npm run gerar-chaves
npm run dev
```

---

## Comandos Disponíveis

| Comando                | Descrição                                 |
|------------------------|-------------------------------------------|
| `npm run dev`          | Desenvolvimento com hot reload            |
| `npm run build`        | Build para produção                       |
| `npm run start`        | Execução no ambiente de produção          |
| `npm run test`         | Execução de testes                        |
| `npm run lint`         | Análise estática de código                |
| `npm run gerar-chaves` | Geração de chaves de demonstração         |

---

## Documentação da API

Após iniciar o servidor local:

- **Swagger UI:** [http://localhost:3000/docs](http://localhost:3000/docs)
- **Redoc:** [http://localhost:3000/redoc](http://localhost:3000/redoc)

### Exemplo: Tela da documentação Swagger

![Exemplo Swagger UI](./docs/example-swagger.png)
<!-- Imagem referência: 1 -->

---

## Exemplos de Uso

### 1. Registro de Usuário

```sh
curl -X POST http://localhost:3000/auth/registrar \
  -H "Content-Type: application/json" \
  -d '{"email":"usuario@exemplo.com","senha":"MinhaSenh@123","nome":"Usuário Teste"}'
```

### 2. Login

```sh
curl -X POST http://localhost:3000/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"usuario@exemplo.com","senha":"MinhaSenh@123"}'
```

### 3. Acessar Rota Protegida

```sh
curl -X GET http://localhost:3000/perfil \
  -H "Authorization: Bearer SEU_ACCESS_TOKEN"
```

### 4. Criptografar Dados

```sh
curl -X POST http://localhost:3000/criptografia/criptografar \
  -H "Authorization: Bearer SEU_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"dados":"Dados sensíveis para criptografar"}'
```

---

## Gerenciamento de Chaves 🔐

- **Nenhuma chave real** é versionada neste repositório.
- O arquivo `.env` deve ser **mantido fora** do controle de versão (`.gitignore`).
- Utilize apenas o `.env.exemplo` como referência.
- Para gerar suas próprias chaves:

```sh
cp .env.exemplo .env
npm run gerar-chaves
```

### Recomendações para Gestão de Segredos

- [AWS Secrets Manager](https://aws.amazon.com/secrets-manager/)
- [HashiCorp Vault](https://www.vaultproject.io/)
- Azure Key Vault
- Google Secret Manager
- Hardware Security Modules (HSM)

---

## Medidas de Segurança Implementadas

✅ **Implementado**

- Hash de senhas (Argon2id)
- JWT assinado com ECDSA P-256
- Refresh tokens com rotação e blacklist
- Criptografia AES-256-GCM e RSA-4096
- Validação de entrada (Joi)
- Rate limiting e proteção brute force
- CORS configurável
- Helmet: headers de segurança
- Logs de eventos de segurança
- Sistema de roles (usuário/admin)

❌ **A IMPLEMENTAR PARA PRODUÇÃO**

- Gestão de chaves com HSM/KMS
- Auditoria de segurança profissional
- Monitoramento avançado (SIEM)
- Backup seguro e rotativo de chaves
- Análise contínua de vulnerabilidades
- Testes de penetração periódicos
- Compliance regulatório
- Plano de disaster recovery
- Autenticação multi-fator (MFA)

---

## Recomendações para Produção

- **Gerenciamento de Segredos:** AWS Secrets Manager, HashiCorp Vault, Azure Key Vault, Google Secret Manager
- **Monitoramento e Logs:** AWS CloudTrail, Splunk, ELK Stack, Datadog Security
- **Banco de Dados:** PostgreSQL com criptografia em repouso, backup seguro, conexões SSL/TLS

---

## Avisos Legais & Éticos

- O código é fornecido **"no estado em que se encontra"**, sem garantias de qualquer tipo.
- Utilize **apenas** para aprendizado e demonstração.
- Não utilize em ambientes de produção sem auditorias e adequações profissionais.
- Sempre realize testes em ambientes isolados.
- Não utilize para atividades ilícitas; siga as leis de privacidade e proteção de dados aplicáveis.

---

## Licença

MIT License — consulte o arquivo [LICENSE](./LICENSE) para mais detalhes.

---

## Contribuição

O projeto é demonstrativo. Contribuições são bem-vindas para fins educacionais.
