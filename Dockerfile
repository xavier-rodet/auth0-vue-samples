FROM node:10-alpine as build

ARG OIDC_DOMAIN
ARG OIDC_CLIENT_ID
ARG BASE_URL=/

ENV OIDC_DOMAIN=$OIDC_DOMAIN
ENV OIDC_CLIENT_ID=$OIDC_CLIENT_ID
ENV BASE_URL=$BASE_URL

RUN apk update && apk upgrade && \
  apk add --no-cache bash git openssh

RUN mkdir /app

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

RUN ./setup-oidc.sh

RUN npm run build

# ---------------

FROM node:10-alpine

ARG BASE_URL=/

ENV NODE_ENV production
ENV BASE_URL=$BASE_URL

RUN mkdir -p /app/dist

WORKDIR /app

COPY --from=build /app/dist ./dist
COPY --from=build /app/package.json .
COPY --from=build /app/vue.config.js .
COPY --from=build /app/auth_config.json .
COPY --from=build /app/web-server.js .

RUN npm install --production

EXPOSE 3000

CMD ["node", "web-server.js"]
