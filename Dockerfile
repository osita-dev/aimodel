# Use Node.js LTS
FROM node:20-alpine

# Set working directory
WORKDIR /app

# Copy package files first
COPY package*.json ./

# Install dependencies
RUN npm install --legacy-peer-deps

# Create model folder
RUN mkdir -p src/ai/model

# Install gdown (Python) to download from Google Drive
RUN apk add --no-cache python3 py3-pip && \
    pip3 install gdown

# Copy model folder locally (your .gguf file)
# Download TinyLlama model from Google Drive
RUN gdown https://drive.google.com/uc?id=1aI7HommJ-YRUvCaOjd4HC8MIPEv5v9Uw -O src/ai/model/tinyllama.gguf

# Expose port
EXPOSE 5000

# Start the server
CMD ["node", "src/server.js"]
