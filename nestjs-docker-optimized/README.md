# 🐳 NestJS + MySQL — Otimização de Dockerfile & CI/CD

Este repositório é um estudo prático de **otimização de imagens Docker** em aplicações **Node.js / NestJS** com **MySQL**, usando:
- **Multi-stage builds** (imagem final menor)
- **Alpine base image**
- **Instalação seletiva de dependências** (prod vs dev)
- **Cache de build** e boas práticas de `.dockerignore`
- **CI/CD com GitHub Actions** para **testar**, **buildar** e **publicar** a imagem no Docker Hub

---

## 📚 Sumário
- [Stack](#-stack)
- [Pré-requisitos](#-pré-requisitos)
- [Variáveis de Ambiente](#-variáveis-de-ambiente)
- [Rodando Localmente (sem Docker)](#-rodando-localmente-sem-docker)
- [Rodando com Docker Compose](#-rodando-com-docker-compose)
- [Scripts pnpm](#-scripts-pnpm)
- [Estratégias de Otimização do Dockerfile](#-estratégias-de-otimização-do-dockerfile)
- [CI/CD (GitHub Actions)](#-cicd-github-actions)
- [Publicação da Imagem](#-publicação-da-imagem)
- [Dicas de Troubleshooting](#-dicas-de-troubleshooting)

---

## 🧰 Stack
- [NestJS](https://nestjs.com/)
- [MySQL 8](https://hub.docker.com/_/mysql)
- [Docker](https://www.docker.com/)
- [pnpm](https://pnpm.io/)

---

## ✅ Pré-requisitos
- Node.js 20+
- pnpm 8+ (ou 10 via Corepack)
- Docker Desktop / Docker Engine 24+
- docker-compose v2 (ou `docker compose`)

> Dica: habilita o Corepack para gerenciar o pnpm:
> ```bash
> corepack enable
> corepack prepare pnpm@latest --activate
> ```

---

## 🔐 Variáveis de Ambiente
Crie um arquivo `.env` na raiz do projeto (e outro para o Compose, se quiser, `.env.compose`), por exemplo:

```env
# .env
NODE_ENV=development
PORT=3000

# Banco
DB_HOST=localhost
DB_PORT=3306
DB_USER=root
DB_PASSWORD=secret
DB_NAME=app_db
