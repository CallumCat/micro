ARG ARCH=
FROM ${ARCH}node:14-alpine
RUN apk add --update \
    --repository http://dl-3.alpinelinux.org/alpine/edge/testing \
    vips-dev fftw-dev \
    && rm -rf /var/cache/apk/*

# RUN apt-get update
# RUN apt-get install make gcc g++ python -y

WORKDIR /opt/micro
COPY package.json yarn.lock ./
# RUN yarn install
RUN apk add --no-cache --virtual .build-deps alpine-sdk python \
    && yarn install --debug 
# && yarn install --debug \
#  &&  \
# && apk del .build-deps

ADD . ./
RUN yarn build

ENV NODE_ENV production
CMD [ "npm", "start" ]