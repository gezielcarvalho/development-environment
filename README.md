# Development container

Standard containers with Apache, PHP v8.1, Laravel v8.83.15, Vue 2, MongoDb, MySQL and PostgreSQL.

| App  | Name  | Port  |
|---|---|---|
|  Laravel 8.83.15 Vue 2.6 | lara | 8009 |
|  ReactJS  | web | 3009  |
|  MongoDb  | mongo | 27019 |
|  MongoExpress | mexpress | 8091 |
|  MariaDB 10.2 (~MySql 5.7) | mydb | 3309 |
|  PhpMyAdmin | myadmin | 8089 |
|  PgDb | pgdb | 5439 |
|  PgAdmin | pgadm | 5059 |

## PHP v8.1.8

Changelog at https://www.php.net/ChangeLog-8.php#8.1.8

## Laravel 8.83.15 (PORT 8009)

Release notes at https://laravel.com/docs/8.x/releases

## Vue 2.6 (embedded in Laravel)

Documentation at https://br.vuejs.org/v2/guide/installation.html


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

https://blog.codeexpertslearning.com.br/dockerizando-uma-aplica%C3%A7%C3%A3o-react-js-f6a22e93bc5d
https://stackoverflow.com/questions/987142/make-gitignore-ignore-everything-except-a-few-files
