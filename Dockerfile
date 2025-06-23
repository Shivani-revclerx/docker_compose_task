# Stage 1: Builder Stage
FROM node:16 AS builder

# Set working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package.json yarn.lock ./
RUN npm install

# Copy the rest of the application code
COPY . .

# Stage 2: Runtime Stage
FROM node:16-slim

# Set working directory
WORKDIR /app

# Copy only the necessary artifacts from the builder stage
COPY --from=builder /app /app

# Expose the application port
EXPOSE 3000

# Start the application
CMD ["node", "index.js"]
