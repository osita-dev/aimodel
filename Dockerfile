# Use Node.js LTS
FROM node:20-alpine

# Set working directory
WORKDIR /app

# Copy package files first
COPY package*.json ./

# Install dependencies
RUN npm install --legacy-peer-deps

# Download model using Python image
FROM python:3.12-alpine AS downloader
RUN pip install gdown
RUN mkdir /model
RUN gdown https://drive.google.com/uc?id=1aI7HommJ-YRUvCaOjd4HC8MIPEv5v9Uw -O /model/tinyllama.gguf


# Copy the downloaded model from the Python stage
COPY --from=downloader /model /app/src/ai/model
# Expose port
EXPOSE 5000

# Start the server
CMD ["node", "src/server.js"]
