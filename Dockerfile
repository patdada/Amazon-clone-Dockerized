# Stage 1: Build dependencies on x86
FROM node:14.17.0-alpine AS build
WORKDIR /usr/src/app
COPY package*.json ./
RUN apk add --no-cache python2 make g++ && npm install

# Stage 2: Copy dependencies to ARM64
FROM node:14.17.0-alpine@sha256:f07ead757c93bc5e9e79978075217851d45a5d8e5c48eaf823e7f12d9bbc1d3c
WORKDIR /usr/src/app
COPY --from=build /usr/src/app/node_modules ./node_modules
COPY . .
EXPOSE 3000
CMD ["npm", "start"]
