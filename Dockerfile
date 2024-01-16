# Stage 1: Build dependencies on x86
FROM node:14.17.0-alpine AS build-x86
WORKDIR /usr/src/app
COPY package*.json ./

# Install build tools
RUN apk add --no-cache python3 make g++

# Stage 2: Install Node.js dependencies on x86
RUN npm install

# Stage 3: Copy dependencies to ARM64
FROM node:14.17.0-alpine@sha256:f07ead757c93bc5e9e79978075217851d45a5d8e5c48eaf823e7f12d9bbc1d3c AS build-arm64
WORKDIR /usr/src/app
COPY --from=build-x86 /usr/src/app/node_modules ./node_modules
COPY . .
EXPOSE 3000
CMD ["npm", "start"]
