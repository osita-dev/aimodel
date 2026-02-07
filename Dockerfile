# --- Stage 1: Download TinyLlama model ---
FROM python:3.12-alpine AS downloader

WORKDIR /tmp

# Install gdown
RUN pip install gdown

# Create folder for model
RUN mkdir -p /tmp/model

# Download model from Google Drive (direct link)
RUN gdown https://drive.google.com/uc?id=1aI7HommJ-YRUvCaOjd4HC8MIPEv5v9Uw -O /tmp/model/tinyllama.gguf

# --- Stage 2: NodeJS app ---
FROM node:20-alpine

WORKDIR /app

# Copy package.json and install dependencies
COPY package.json package-lock.json* ./
RUN npm install --legacy-peer-deps

# Copy source code
COPY src ./src

# Copy model from Python stage
COPY --from=downloader /tmp/model /app/src/ai/model

# Expose your port
EXPOSE 5000

# Start the server
CMD ["node", "src/server.js"]
