FROM php:8.1-apache

RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -

RUN apt-get update 

# https://github.com/docker-library/php/issues/221
RUN apt-get install -y nodejs libcurl4-openssl-dev pkg-config libssl-dev libpq-dev libzip-dev zip libgmp-dev libmcrypt-dev libmagickwand-dev --no-install-recommends 

RUN pecl install imagick 
 
RUN docker-php-ext-enable imagick 

RUN pecl install mongodb 

RUN docker-php-ext-enable mongodb 

# GMP https://stackoverflow.com/questions/64702858/installing-gmp-extention-on-php-7-4-fpm-aplpine-docker/71739173#71739173
# ZIP - https://stackoverflow.com/questions/48700453/docker-image-build-with-php-zip-extension-shows-bundled-libzip-is-deprecated-w
RUN docker-php-ext-install sockets mysqli pdo pdo_mysql pdo_pgsql zip pcntl gmp bcmath

# JPEG - https://stackoverflow.com/a/52892313/2190689
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN mkdir /var/www/html/public

RUN sed -ri -e 's!/var/www/html!/var/www/html/public!g' /etc/apache2/sites-available/*.conf

RUN a2enmod rewrite 

RUN service apache2 restart

RUN usermod -u 1000 www-data