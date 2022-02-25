FROM node:14.17.6

WORKDIR /spaceFront

ENV PORT 8080

COPY package.json /spaceFront/package.json

RUN yarn install

COPY . /spaceFront/

CMD ["yarn", "serve"]