FROM ubuntu:18.04
MAINTAINER Adam Duncan <adam.jd@gmail.com>

# Useful base packages
RUN apt-get update && apt-get -y install curl
RUN locale-gen en_GB en_GB.UTF-8

# Install node
RUN curl https://raw.github.com/isaacs/nave/master/nave.sh > /bin/nave && chmod a+x /bin/nave
RUN nave usemain stable

ADD package.json /src/package.json

RUN cd /src && npm install

# App
ADD . /src

EXPOSE 6500
CMD ["node", "/src/index.js"]
