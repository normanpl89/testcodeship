FROM node:7.7.2-debian:sid


WORKDIR /usr/app

RUN apk update && apk add postgresql

COPY package.json .
RUN npm install --quiet

COPY . .

RUN apt-get update && \
  apt-get install -y \
    supervisor \
    netcat-traditional \
    xvfb \
    openjdk-8-jre \
    chromium \
    firefox \
    ffmpeg \
    curl \
    gnupg \
  && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
  apt-get update && \
  apt-get install -y nodejs && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# Install Protractor and initialized Webdriver
RUN npm install -g protractor@^5.4 && \
  webdriver-manager update
