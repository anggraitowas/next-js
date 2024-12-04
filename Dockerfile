# Menggunakan image Node.js
FROM node:22 AS builder

# Set working directory
WORKDIR /app

# Copy package.json dan package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy semua file
COPY . .

# Build aplikasi
RUN npm run build
RUN npm run export

# Stage untuk server
FROM nginx:alpine
COPY --from=builder /app/out /usr/share/nginx/html

# Expose port
EXPOSE 3000

# Jalankan nginx
CMD ["nginx", "-g", "daemon off;"]