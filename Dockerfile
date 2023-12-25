FROM node:14

ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

WORKDIR /usr/src/app

COPY package.json ./
COPY yarn.npm.lock .

RUN npm install 

COPY . . 

CMD ["npm", "start"]
