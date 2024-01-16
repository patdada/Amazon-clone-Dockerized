# Stage 1: Build dependencies on x86
FROM node:14.17.0-alpine AS build
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install

# Stage 2: Copy dependencies to ARM64
FROM arm64v8/node:14.17.0-alpine
WORKDIR /usr/src/app
COPY --from=build /usr/src/app/node_modules ./node_modules
COPY . .

# Create a non-root user
RUN addgroup -g 1001 appuser && adduser -u 1001 -G appuser -D appuser

# Change to the non-root user
USER appuser

EXPOSE 3000
CMD ["npm", "start"]
