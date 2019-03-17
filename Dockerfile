FROM node:10.15.3-alpine

ADD package.json /src/package.json

RUN cd /src && npm install

# App
ADD . /src

EXPOSE 6500
CMD ["node", "/src/index.js"]
