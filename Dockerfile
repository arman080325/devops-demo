# FROM node:22-alpine AS build
# WORKDIR /app
# COPY package*.json .
# RUN npm install
# COPY . ./
# RUN npm run build
# RUN ls /app

# FROM nginx:1.27.1-alpine
# COPY nginx.conf /etc/nginx/conf.d/default.conf
# COPY --from=build /app/dist /usr/share/nginx/html
# Stage 1: Build React/Vite app
FROM node:22-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build
# Stage 2: Serve with Nginx
FROM nginx:1.27.1-alpine
# 👇 Fix: Copy full nginx.conf to correct path
COPY nginx.conf /etc/nginx/nginx.conf
# 👇 Copy built frontend files
COPY --from=build /app/dist /usr/share/nginx/html
