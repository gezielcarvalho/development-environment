Here’s how to update the README file with **instructions for the initial setup** using the `init-containers.sh` script. The update includes how the script works, what it does, and a warning for users about resetting their `.env` and `docker-compose.yaml`.

---

# Development Container

This repository sets up a development environment using Docker with various containers for tools and frameworks, including NGinx, Apache, PHP, Laravel, Vue.js, MongoDB, MySQL, SQL Server, and PostgreSQL.

---

## Table of Contents

1. [Overview](#overview)
2. [Getting Started](#getting-started)
   - [Initial Setup Script](#initial-setup-script)
   - [Configure SSH for Git](#configure-ssh-for-git)
   - [Configure GPG Keys](#configure-gpg-keys)
   - [Run Containers](#run-containers)
3. [Services](#services)
4. [MacOS Setup](#macos-setup)
5. [WSL Setup](#wsl-setup)
   - [Backup and Restore WSL Drive](#backup-and-restore-wsl-drive)
   - [Troubleshooting](#troubleshooting)
6. [Changelog](#changelog)

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

### Initial Setup Script

This repository includes an **initialization script** to automate the setup process. The script will:

1. Reset and copy:
   - `.env.example` → `.env`
   - `docker-compose.example.yaml` → `docker-compose.yaml`
2. Create all required folders for volume bindings.
3. Set appropriate permissions and ownership for these folders.
4. Start the Docker containers (`docker compose up -d`).

---

### Running the Script

1. **Warning**:
   The script will overwrite any modifications to `.env` and `docker-compose.yaml`. Ensure you back up these files if needed.

2. **Steps**:
   - Before running the script, ensure it has the correct permissions:

   ```bash
   chmod +x init.sh
   ```
   - Run the script from your project root:

   ```bash
   ./init.sh
   ```

3. **What Happens**:
   - The script will:
     - Copy example files to their working versions.
     - Create and set up required directories for containers (e.g., `./.docker/sqldata`, `./.docker/mgdata`).
     - Set permissions for Docker volumes.
     - Start all containers.

4. **Logs**:
   - The script logs each action for transparency. Review the logs if any errors occur.

---

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

---

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

---

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
   docker exec -it php-app bash
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

## Changelog

- **Initial Setup**: Added `init.sh` for automated environment setup.
- **Containers**: Set up Laravel, MongoDB, SQL Server, and PostgreSQL environments.

---

### Notes: