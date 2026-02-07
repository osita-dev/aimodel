# Use Node.js LTS
FROM node:20-alpine

# Set working directory
WORKDIR /app

# Copy package files first
COPY package*.json ./

# Install dependencies
RUN npm install --legacy-peer-deps


# Copy model folder locally (your .gguf file)
RUN mkdir -p C:\Users\Osita Dimma\OneDrive\Desktop\purpleschol\model
RUN wget -O C:\Users\Osita Dimma\OneDrive\Desktop\purpleschol\model

# Expose port
EXPOSE 5000

# Start the server
CMD ["node", "src/server.js"]
