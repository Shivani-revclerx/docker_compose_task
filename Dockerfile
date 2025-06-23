FROM node:18 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build || echo "skip build"

FROM node:18-alpine
WORKDIR /app
COPY --from=builder /app .
CMD ["node", "index.js"]





# this file is for Multi-stage build..........................