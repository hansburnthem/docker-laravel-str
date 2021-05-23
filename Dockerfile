FROM node:lts As node
FROM php:7.4-fpm

ARG user
ARG uid

RUN apt-get update && apt-get install -y git curl libpng-dev libonig-dev libxml2-dev zip unzip nano htop

RUN apt-get clean && rm -rf /var/lib/apt/list/*

RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=node /usr/local/bin/node /usr/local/bin/node
RUN ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm

RUN useradd -G www-data,root -u $uid -d /home/$user $user
RUN mkdir -p /home/$user/.composer && chown -R $user:$user /home/$user

WORKDIR /var/www

#COPY package.json /var/www/testing
#RUN npm install

USER $user