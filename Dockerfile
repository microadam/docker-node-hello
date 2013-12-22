# DOCKER-VERSION 0.7.2

FROM stackbrew/ubuntu:13.04
MAINTAINER Adam Duncan <adam.jd@gmail.com>

RUN echo "deb http://archive.ubuntu.com/ubuntu raring main universe" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y upgrade

# Useful base packages
RUN apt-get -y install curl
RUN locale-gen en_GB en_GB.UTF-8

# Install node
RUN curl https://raw.github.com/isaacs/nave/master/nave.sh > /bin/nave && chmod a+x /bin/nave
RUN nave usemain stable

# App
ADD . /src

EXPOSE 6500
CMD ["node", "/src/index.js"]