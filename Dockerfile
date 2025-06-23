# FROM node:18 AS builder
# WORKDIR /app
# COPY package*.json ./
# RUN npm install
# COPY . .
# RUN npm run build || echo "skip build"

# FROM node:18-alpine
# WORKDIR /app
# COPY --from=builder /app .
# CMD ["node", "index.js"]





# # this file is for Multi-stage build..........................

# Step 1: Builder stage (build the app)
FROM node:18 AS builder

# Set working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json for dependencies installation
COPY package.json package-lock.json ./
RUN npm install

# Copy the rest of the application code
COPY . .

# Step 2: Runtime stage (build the runtime image)
FROM node:18-slim AS runtime

# Set the working directory for the runtime environment
WORKDIR /app

# Copy only necessary files from the builder stage (node_modules and dist)
COPY --from=builder /app /app

# Expose the port on which the app runs
EXPOSE 3000

# Set the command to run the app in production
CMD ["npm", "start"]
