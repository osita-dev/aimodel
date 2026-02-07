# Use Node.js LTS
FROM node:20-alpine

# Set working directory
WORKDIR /app

# Copy package files first
COPY package*.json ./

# Install dependencies
RUN npm install --legacy-peer-deps

# Copy source code
COPY src ./src
COPY knowledge ./knowledge

# Copy model folder locally (your .gguf file)
COPY src/ai/model/tinyllama-1.1b-chat-v1.0.Q2_K.gguf ./src/ai/model/tinyllama-1.1b-chat-v1.0.Q2_K.gguf

# Expose port
EXPOSE 5000

# Start the server
CMD ["node", "src/server.js"]
