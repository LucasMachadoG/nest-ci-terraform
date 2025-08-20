# Etapa de build
FROM node:20-alpine3.21 AS build

# Habilita o Corepack com pnpm
RUN corepack enable && corepack prepare pnpm@latest --activate

# Define o diretório de trabalho
WORKDIR /usr/src/app

# Copia apenas os arquivos necessários para instalar as dependências
COPY package.json pnpm-lock.yaml ./

# Instala todas as dependências (dev + prod)
RUN pnpm install --frozen-lockfile

# Copia o restante da aplicação
COPY . .

# Gera o build da aplicação
RUN pnpm run build

# Remove dependências de desenvolvimento, deixando só as de produção
RUN pnpm install --prod --frozen-lockfile

# Etapa final para produção
FROM node:20-alpine3.21 AS runner

# Habilita o Corepack com pnpm
RUN corepack enable && corepack prepare pnpm@latest --activate

# Define o diretório de trabalho
WORKDIR /usr/src/app

# Copia somente o necessário da etapa de build
COPY --from=build /usr/src/app/package.json ./
COPY --from=build /usr/src/app/dist ./dist
COPY --from=build /usr/src/app/node_modules ./node_modules

# Expõe a porta da aplicação NestJS
EXPOSE 3000

# Comando para iniciar a aplicação
CMD ["pnpm", "run", "start:prod"]