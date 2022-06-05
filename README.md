# Development container

Standard container with PHP 8.1, Laravel 8, VueJS, ReactJS, React Native, MySQL and PostgreSQL.

## PHP main config and libs

1. libzip-dev zip libmcrypt-dev libmagickwand-dev wget git libpq-dev libgmp-dev

### Container names

docker compose up -d --build

### Run containers

docker compose up -d --build

### Check if they are running

docker ps

### Install dependencies

**Acesse o bash do container <INSTALL_DIR>_php_1**

docker exec -it <INSTALL_DIR>_php_1 bash

**Execute a instalação das dependências com o composer**

composer install

**Execute a instalação das dependências com o node e compile**

npm install

npm run dev

### Concluir configurações do Laravel

cp .env.example .env

php artisan key:generate

php artisan migrate

### Em ambiente Linux (tomara) ajuste as permissões de storage

chmod -R 775 storage

# Vue
https://www.positronx.io/create-laravel-vue-js-crud-single-page-application/

# React
https://techvblogs.com/blog/build-crud-app-with-laravel-and-reactjs