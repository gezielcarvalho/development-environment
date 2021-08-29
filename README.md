# Container com Laravel 8
 
Container padrão pra executar as atividades de desenvolvimento do **sabre**.

## Procedimentos com docker 

### Levantar container

docker compose up -d --build

### Verificar se os containers estão rodando

docker ps

### Instalar dependências

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

php artinan migrate
