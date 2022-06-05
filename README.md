# Development container

Standard container with Laravel v8.83.15 (PHP v8.1.6), MySQL and PostgreSQL.

## PHP main config and libs

1. libzip-dev zip libmcrypt-dev libmagickwand-dev wget git libpq-dev libgmp-dev

### Container names

docker compose up -d --build

### Run containers

docker compose up -d --build

### Check if they are running

docker ps

### Install Larvel dependencies

docker exec -it lara bash
composer install

### Install node dependencies inside Laravel container

npm install
npm run dev

### Set Laravel environment variables

cp .env.example .env
php artisan key:generate

### Create database schema and populate with data

php artisan migrate
php artisan seed

### User and permission settings

chmod -R 777 storage

After creating files with artisan, run the following command to avoid permission issues

chown -R www-data:1000 .

## Vue app

<https://www.positronx.io/create-laravel-vue-js-crud-single-page-application/>

## React

<https://techvblogs.com/blog/build-crud-app-with-laravel-and-reactjs>