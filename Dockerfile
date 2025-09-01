# See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

# Depending on the operating system of the host machines(s) that will build or run the containers, the image specified in the FROM statement may need to be changed.
# For more information, please see https://aka.ms/containercompat

# This stage is used when running from VS in fast mode (Default for Debug configuration)
FROM mcr.microsoft.com/dotnet/aspnet:8.0-nanoserver-1809 AS base
WORKDIR /app
EXPOSE 8080
EXPOSE 8081


# This stage is used to build the service project
FROM mcr.microsoft.com/dotnet/sdk:8.0-nanoserver-1809 AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src
COPY ["TJTaskReporting.csproj", "."]
RUN dotnet restore "./TJTaskReporting.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "./TJTaskReporting.csproj" -c %BUILD_CONFIGURATION% -o /app/build

# This stage is used to publish the service project to be copied to the final stage
FROM build AS publish
ARG BUILD_CONFIGURATION=Release
RUN dotnet publish "./TJTaskReporting.csproj" -c %BUILD_CONFIGURATION% -o /app/publish /p:UseAppHost=false

# This stage is used in production or when running from VS in regular mode (Default when not using the Debug configuration)
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "TJTaskReporting.dll"]
#-------------------------------------------------------------------
# # Stage 1: Builder Stage
# FROM node:16 AS builder

# # Set working directory
# WORKDIR /app

# # Copy package.json and install dependencies
# COPY package.json yarn.lock ./
# RUN npm install

# # Copy the rest of the application code
# COPY . .

# # Stage 2: Runtime Stage
# FROM node:16-slim

# # Set working directory
# WORKDIR /app

# # Copy only the necessary artifacts from the builder stage
# COPY --from=builder /app /app

# # Expose the application port
# EXPOSE 3000

# # Start the application
# CMD ["node", "index.js"]

# # Use Node base image
# FROM node:16

# # Set working directory
# WORKDIR /app

# # Copy package.json only (no yarn.lock)
# COPY package.json ./

# # Install dependencies using npm
# RUN npm install

# # Copy rest of the project files
# COPY . .

# # Expose app port (if needed)
# EXPOSE 3000

# # Default command
# CMD ["npm", "start"]

