FROM node:lts-alpine
RUN apk add --no-cache libc6-compat

WORKDIR /proxy

COPY src /proxy/src
COPY package.json /proxy/package.json
COPY tsconfig.json /proxy/tsconfig.json

RUN npm install
RUN npm run build

RUN rm -r /proxy/src
RUN rm /proxy/package.json /proxy/tsconfig.json /proxy/package-lock.json

ENV PORT=3000

ENTRYPOINT [ "node","./build/wss.server.js" ]