# Container para Laravel

Container padrão pra executar as atividades de desenvolvimento do **sabre**.

## Procedimentos com docker 

### Levantar container

docker compose up -d --build

### Verificar se os containers estão rodando
docker ps

## Instalar laravel

Para criar um projeto Laravel, remova a pasta *www* (rm -fR www), em seguida, use o comando abaixo.

composer create-project laravel/laravel www

### Caso queira deixar o instalador do Laravel em seu sistema, 

composer global require laravel/installer

laravel new www

### Configurar informações de banco de dados no .env

Após instalar o laravel, definir as variáveis de ambiente para acesso ao container de BD

DB_CONNECTION=mysql
DB_HOST=db
DB_PORT=3306
DB_DATABASE=laravel
DB_USERNAME=root
DB_PASSWORD=A_1234567

### Criar o banco de dados

Acessar http://localhost:8080, onde está instalado o phpmyadmin, e criar o BD com o nome laravel ou outro que tiver escolhido.

## Simplificar controller nas rotas.

### Acessar 
\www\app\Providers\RouteServiceProvider.php

### descomentar a linha abaixo.
protected $namespace = 'App\\Http\\Controllers';



Para instalar o nodejs, substitua 10.x abaixo pela última versão estável

cd ~
curl -sL https://deb.nodesource.com/setup_10.x -o nodesource_setup.sh
sudo bash nodesource_setup.sh
sudo apt-get install -y nodejs

Problema de verificação e certificado SSL

git config --global http.sslVerify false

Referências:

1. [link to Instalação do Laravel 8] (https://laravel.com/docs/8.x/installation)
2. https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-18-04-pt
3. https://confluence.atlassian.com/fishkb/unable-to-clone-git-repository-due-to-self-signed-certificate-376838977.html
