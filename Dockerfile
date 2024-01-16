# Stage 1: Build dependencies and application
FROM node:14.17.0-alpine AS build
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .
RUN make build

# Stage 2: Create runtime image
FROM alpine
RUN addgroup -S nonroot \
    && adduser -S nonroot -G nonroot
WORKDIR /app
COPY --from=build /usr/src/app/bin/production .
EXPOSE 3000
USER nonroot
CMD ["./production"]
