FROM node:20-alpine as builder

RUN npm install -g pnpm

WORKDIR /app

COPY package.json pnpm-lock.yaml .
RUN pnpm i

COPY docs ./docs
RUN pnpm build

RUN pnpm prune --prod

# ========================
FROM lipanski/docker-static-website:latest
COPY docs/.vitepress/dist .