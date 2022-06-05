FROM php:7.4-apache

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -

RUN apt-get update 

RUN apt-get install -y nodejs libzip-dev zip libmcrypt-dev libmagickwand-dev --no-install-recommends 

RUN pecl install imagick 

RUN docker-php-ext-enable imagick 

RUN docker-php-ext-install mysqli pdo pdo_mysql zip

RUN mkdir /var/www/html/public

RUN sed -ri -e 's!/var/www/html!/var/www/html/public!g' /etc/apache2/sites-available/*.conf

RUN a2enmod rewrite 

RUN service apache2 restart

RUN usermod -u 1000 www-data