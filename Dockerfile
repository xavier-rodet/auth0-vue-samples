ARG OIDC_DOMAIN
ARG OIDC_CLIENT_ID
ARG BASE_URL=/

FROM node:10-alpine as build

RUN apk update && apk upgrade && \
  apk add --no-cache bash git openssh

RUN mkdir /app

WORKDIR /app

COPY vue.config.js .
COPY package.json .

RUN npm install

COPY . .

RUN ./setup-oidc.sh

RUN npm run build

# ---------------

FROM node:10-alpine

RUN mkdir -p /app/dist

WORKDIR /app

COPY --from=build /app/dist ./dist
COPY --from=build /app/package.json .
COPY --from=build /app/auth_config.json .
COPY --from=build /app/web-server.js .

ENV NODE_ENV production

RUN npm install --production

EXPOSE 3000

CMD ["node", "web-server.js"]
