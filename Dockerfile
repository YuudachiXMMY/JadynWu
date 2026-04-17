# ── JadynWu-site (Gatsby → Nginx) ── Production ──
# Multi-stage build: install deps → build static site → serve via Nginx

FROM node:20-slim AS deps
WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

FROM deps AS build
COPY . .
RUN yarn build

FROM nginx:alpine AS runner
COPY --from=build /app/public /usr/share/nginx/html
EXPOSE 80
