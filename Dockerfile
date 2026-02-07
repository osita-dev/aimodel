# --- Stage 1: Download TinyLlama model ---
FROM python:3.12-slim AS downloader

WORKDIR /tmp

# Install gdown (for downloading from Google Drive)
RUN pip install --no-cache-dir gdown

# Create folder for model
RUN mkdir -p /tmp/model

# Download model from Google Drive (direct link)
RUN gdown https://drive.google.com/uc?id=1aI7HommJ-YRUvCaOjd4HC8MIPEv5v9Uw -O /tmp/model/tinyllama.gguf

# --- Stage 2: NodeJS app ---
FROM node:20-bullseye

WORKDIR /app

# Install build tools, git, Python (needed for node-llama-cpp)
RUN apt-get update && \
    apt-get install -y git build-essential python3 python3-pip cmake && \
    rm -rf /var/lib/apt/lists/*

# Copy package.json and install dependencies
COPY package.json package-lock.json* ./
RUN npm install --legacy-peer-deps

# Copy source code
COPY src ./src

# Copy model from Python stage
COPY --from=downloader /tmp/model /app/src/ai/model

# Expose your app port
EXPOSE 5000

# Start the server
CMD ["node", "src/server.js"]
