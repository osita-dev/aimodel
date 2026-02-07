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
RUN mkdir -p src/ai/model
RUN wget -O src/ai/model/tinyllama.gguf https://huggingface.co/.../tinyllama.gguf

# Expose port
EXPOSE 5000

# Start the server
CMD ["node", "src/server.js"]
