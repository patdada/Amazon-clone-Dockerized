# Stage 1: Build dependencies on x86
FROM node:14.17.0-alpine AS build
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install

# Stage 2: Copy dependencies to ARM64
FROM arm64v8/node:14.17.0-alpine
WORKDIR /usr/src/app
COPY --from=buildx build /usr/src/app/node_modules ./node_modules
COPY . .
EXPOSE 3000
CMD ["npm", "start"]
