ARG ARCH=
FROM ${ARCH}alpine:edge

WORKDIR /opt/micro

# nodejs & sharp dependencies
RUN apk add --update --no-cache nodejs nodejs-npm nodejs
RUN apk add vips-dev fftw-dev build-base python2 --update --no-cache \
    --repository https://mirror.aarnet.edu.au/pub/alpine/edge/testing/ \
    --repository https://mirror.aarnet.edu.au/pub/alpine/edge/main/

RUN npm set progress=false
RUN npm config set depth 0
RUN npm i -g yarn

# install deps
COPY package.json yarn.lock ./
RUN yarn install

# build micro
COPY . ./
RUN yarn build 

CMD ["npm", "start"]
# ARG ARCH=
# FROM ${ARCH}node:14

# WORKDIR /opt/micro
# COPY package.json yarn.lock ./
# RUN yarn install

# ADD . ./
# RUN yarn build

# ENV NODE_ENV production
# CMD [ "npm", "start" ]