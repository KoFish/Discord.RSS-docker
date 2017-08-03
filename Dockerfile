FROM ubuntu:16.04
LABEL maintainer "knuschprig <contact@knuschprig.ch>"

# Base image setup and important dependencies
RUN apt-get update && apt-get upgrade -y && apt-get install sudo
RUN curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
RUN apt-get install nodejs npm git -y 
WORKDIR /opt
RUN git clone https://github.com/synzen/Discord.RSS.git
WORKDIR /opt/Discord.RSS
RUN npm install

RUN chmod 0755 /opt/Discord.RSS/* 
RUN adduser -D feedbot

USER feedbot
VOLUME ["/opt/Discord.RSS/"]
WORKDIR /opt/Discord.RSS

ENV PATH="/opt/Discord.RSS/"
CMD ["nodejs", "./server.js"]
