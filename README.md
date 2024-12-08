Here is a revised version of your README file with improvements, corrections, and a **Table of Contents** for better organization:

---

# Development Container

This repository sets up a development environment using Docker with various containers for tools and frameworks, including NGinx, Apache, PHP, Laravel, Vue.js, MongoDB, MySQL, SQL Server, and PostgreSQL.

## Table of Contents

1. [Overview](#overview)
2. [Getting Started](#getting-started)
   - [Configure SSH for Git](#configure-ssh-for-git)
   - [Configure GPG Keys](#configure-gpg-keys)
   - [Run Containers](#run-containers)
3. [Services](#services)
4. [Setting Up Applications](#setting-up-applications)
   - [Laravel](#laravel)
   - [Vue.js](#vuejs)
   - [React](#react)
   - [MongoDB](#mongodb)
   - [SQL Server](#sql-server)
5. [MacOS Setup](#macos-setup)
6. [WSL Setup](#wsl-setup)
   - [Backup and Restore WSL Drive](#backup-and-restore-wsl-drive)
   - [Troubleshooting](#troubleshooting)
7. [Changelog](#changelog)

---

## Overview

The setup includes standard containers for the following tools and applications:

| App                       | Name      | Port  |
| ------------------------- | --------- | ----- |
| SQL Server                | sqlserver | 1434  |
| Ubuntu/Nginx              | nginx     | 8081  |
| MongoDB                   | mongo     | 27019 |
| MongoExpress              | mexpress  | 8091  |
| MariaDB 10.2 (~MySQL 5.7) | mydb      | 3309  |
| PhpMyAdmin                | myadmin   | 8089  |
| PostgreSQL                | pgdb      | 5439  |
| PgAdmin                   | pgadm     | 5059  |
| Node.js                   | node      | 3000  |

---

## Getting Started

### Configure SSH for Git

1. Generate SSH keys:
   ```bash
   ssh-keygen -t ed25519 -C "your_email@example.com"
   ```
2. Add the SSH key to GitHub by copying the public key:
   ```bash
   cat ~/.ssh/id_ed25519.pub
   ```
   Add it to [GitHub SSH Keys](https://github.com/settings/keys).

### Configure GPG Keys

1. Check for existing keys:
   ```bash
   gpg --list-secret-key --keyid-form long
   ```
2. Generate a new GPG key:
   ```bash
   gpg --full-generate-key
   ```
3. Export the public key:
   ```bash
   gpg --armor --export <KEY_ID>
   ```
   Add it to [GitHub GPG Keys](https://docs.github.com/en/authentication/managing-commit-signature-verification/telling-git-about-your-signing-key).

4. Set the signing key globally:
   ```bash
   git config --global user.signingkey <KEY_ID>
   git config --global commit.gpgsign true
   ```

5. Update `.bashrc` or `.profile` to define `GPG_TTY`:
   ```bash
   export GPG_TTY=$(tty)
   source ~/.bashrc
   ```

#### Troubleshooting GPG

*Remove gpg-agent Socket Files*

The gpg-agent may be stuck due to stale socket files. Remove these manually:

Navigate to the GPG directory:

```bash
Copy code
cd ~/.gnupg
Delete the S.gpg-agent files:
```


```bash
Copy code
rm -f S.gpg-agent*
Restart the gpg-agent:
```

```bash
Copy code
gpgconf --launch gpg-agent
```

### Run Containers

1. Start the containers:
   ```bash
   docker compose up -d --build
   ```
2. Verify containers are running:
   ```bash
   docker ps
   ```

---

## Services

### Laravel

1. Install dependencies:
   ```bash
   docker exec -it lara bash
   composer install
   npm install
   npm run dev
   ```
2. Set up the environment:
   ```bash
   cp .env.example .env
   php artisan key:generate
   php artisan migrate
   php artisan db:seed
   ```
3. Fix permissions:
   ```bash
   chmod -R 777 storage
   chown -R www-data:1000 .
   ```

### Vue.js

- Guide: [Laravel Vue.js CRUD](https://www.positronx.io/create-laravel-vue-js-crud-single-page-application/)

### React

- Guides:
  - [Laravel React CRUD](https://techvblogs.com/blog/build-crud-app-with-laravel-and-reactjs)
  - [Dockerizing React App](https://blog.codeexpertslearning.com.br/dockerizando-uma-aplica%C3%A7%C3%A3o-react-js-f6a22e93bc5d)

### MongoDB

1. Connect using `mongosh`:
   ```bash
   mongosh --username "root" --password "password"
   ```

### SQL Server

- Guide: [SQL Server in Docker](https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-docker-container-configure)

---

## MacOS Setup

Instructions to be added...

---

## WSL Setup

### Backup and Restore WSL Drive

1. **Backup**:
   Copy the following file:
   ```
   C:\Users\<username>\AppData\Local\Packages\CanonicalGroupLimited.Ubuntu_79rhkp1fndgsc\LocalState\ext4.vhdx
   ```

2. **Restore**:
   Shutdown WSL and replace the file:
   ```bash
   wsl --shutdown
   ```

3. Restart WSL:
   ```bash
   wsl
   ```

---

## Troubleshooting

- [Uninstall WSL2](https://pureinfotech.com/uninstall-wsl2-windows-10/)
- [Docker Engine Installation for Ubuntu](https://docs.docker.com/engine/install/ubuntu/)

---

## Changelog

- **Initial Setup**: Added SSH and GPG key configuration.
- **Containers**: Set up Laravel, Vue.js, React, MongoDB, SQL Server, and PostgreSQL environments.

---
