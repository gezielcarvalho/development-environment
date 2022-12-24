FROM php:5.6-apache

RUN apt-get update 

# RUN apt install git

# GMP https://stackoverflow.com/questions/64702858/installing-gmp-extention-on-php-7-4-fpm-aplpine-docker/71739173#71739173
RUN docker-php-ext-install mysqli pdo pdo_mysql pcntl bcmath

RUN mkdir /var/www/html/public

RUN sed -ri -e 's!/var/www/html!/var/www/html/public!g' /etc/apache2/sites-available/*.conf

RUN a2enmod rewrite 

RUN service apache2 restart

RUN usermod -u 1000 www-data