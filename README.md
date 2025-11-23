# Docker Development Environment Multi-Tool

A comprehensive Docker-based development environment that provides instant access to multiple databases, web servers, runtime environments, and development tools. This repository eliminates the need to install and configure development dependencies on your local machine—everything runs in isolated Docker containers.

> **Primary Platform**: Optimized for Ubuntu and WSL2. MacOS and Windows users may need minor adjustments.

---

## Table of Contents

- [Docker Development Environment Multi-Tool](#docker-development-environment-multi-tool)
  - [Table of Contents](#table-of-contents)
  - [Overview](#overview)
    - [Key Benefits](#key-benefits)
  - [Available Services](#available-services)
  - [Quick Start](#quick-start)
    - [Automated Setup](#automated-setup)
    - [Manual Setup](#manual-setup)
  - [Service-Specific Guides](#service-specific-guides)
    - [.NET Applications](#net-applications)
    - [PHP/Laravel Applications](#phplaravel-applications)
    - [Node.js Applications](#nodejs-applications)
    - [MongoDB](#mongodb)
    - [SQL Server](#sql-server)
  - [Platform-Specific Setup](#platform-specific-setup)
    - [WSL2 Setup](#wsl2-setup)
      - [Backup and Restore WSL Distribution](#backup-and-restore-wsl-distribution)
      - [WSL Performance Optimization](#wsl-performance-optimization)
    - [MacOS Setup](#macos-setup)
  - [Advanced Configuration](#advanced-configuration)
    - [Environment Variables](#environment-variables)
    - [Custom Overrides](#custom-overrides)
  - [Development Tools](#development-tools)
    - [Configure SSH for Git](#configure-ssh-for-git)
    - [Configure GPG Keys](#configure-gpg-keys)
  - [Troubleshooting](#troubleshooting)
    - [Common Issues](#common-issues)
    - [Useful Commands](#useful-commands)
  - [Project Structure](#project-structure)
  - [Contributing](#contributing)
  - [License](#license)
  - [Additional Resources](#additional-resources)

---

## Overview

This multi-tool development environment provides containerized access to:

- **Databases**: MongoDB, MySQL/MariaDB, PostgreSQL, SQL Server
- **Database Management**: Mongo Express, phpMyAdmin, pgAdmin
- **Runtime Environments**: .NET, PHP, Node.js
- **Web Servers**: Nginx (for static/SPA hosting)
- **SSH Access**: Remote deployment capabilities for .NET containers

### Key Benefits

✅ **No Local Installation Required** - All tools run in Docker containers  
✅ **Isolated Environments** - Each service runs independently  
✅ **Version Control** - Easily switch between different versions  
✅ **Multi-Project Support** - Work on multiple projects simultaneously  
✅ **Quick Setup** - Automated initialization script  
✅ **Cross-Platform** - Works on WSL2, Linux, and MacOS

---

## Available Services

| Service             | Container  | Port      | Description                  |
| ------------------- | ---------- | --------- | ---------------------------- |
| .NET Application    | dotnet-app | 5008/5009 | ASP.NET Core with SSH access |
| PHP Application     | php-app    | 8009      | PHP runtime with Apache      |
| Node.js Application | node       | 3000      | Node.js development server   |
| Nginx               | nginx      | 8081      | Static file & SPA hosting    |
| SQL Server          | sqlserver  | 1434      | Microsoft SQL Server 2019+   |
| MongoDB             | mongo      | 27019     | NoSQL document database      |
| Mongo Express       | mexpress   | 8091      | MongoDB web interface        |
| MariaDB 10.2        | mydb       | 3309      | MySQL-compatible database    |
| phpMyAdmin          | myadmin    | 8089      | MySQL/MariaDB web interface  |
| PostgreSQL          | pgdb       | 5439      | Relational database          |
| pgAdmin             | pgadm      | 5059      | PostgreSQL web interface     |

---

## Quick Start

### Automated Setup

The fastest way to get started is using the included initialization script:

**⚠️ Warning**: This script will overwrite `.env` and `docker-compose.yaml` files. Back them up if you have existing modifications.

**⚠️ Warning**: This script will overwrite `.env` and `docker-compose.yaml` files. Back them up if you have existing modifications.

1. **Make the script executable**:

   ```bash
   chmod +x init.sh
   ```

2. **Run the initialization script**:

   ```bash
   ./init.sh
   ```

3. **What the script does**:

   - Copies `.env.example` → `.env`
   - Copies `docker-compose.example.yaml` → `docker-compose.yaml`
   - Creates required volume directories
   - Sets appropriate permissions
   - Builds and starts all containers
   - Configures .NET container permissions
   - Exports SSL certificate for development

4. **Verify services are running**:
   ```bash
   docker ps
   ```

### Manual Setup

If you prefer manual control:

1. **Copy configuration files**:

   ```bash
   cp .env.example .env
   cp docker-compose.example.yaml docker-compose.yaml
   ```

2. **Create required directories**:

   ```bash
   mkdir -p .docker/{sqldata/data,mgdata/{db,dev.archive,production},mydata,pgdata,pgadmin}
   ```

3. **Set permissions**:

   ```bash
   sudo chown -R $USER:$USER .docker
   sudo chmod -R 777 .docker
   ```

4. **Start containers**:
   ```bash
   docker compose up -d --build
   ```

---

## Service-Specific Guides

### .NET Applications

The .NET container includes SSH access for remote deployment and debugging.

**Access via SSH**:

```bash
ssh deploy@localhost -p 2222
# Password: deploypassword (configurable in .env)
```

**SSL Certificate Setup** (for HTTPS development):

1. After running `init.sh`, import `localhost.pfx` into Windows Trusted Root Certification Authorities
2. Access your app:
   - HTTP: `http://localhost:5008`
   - HTTPS: `https://localhost:5009`

**Deploy your application**:

- Place your .NET project in `./containers/dotnet-app/`
- The container will automatically detect and run it

### PHP/Laravel Applications

**Initial Setup**:

1. Place your PHP/Laravel project in `./containers/php-app/`

2. **Access the PHP container**:

   ```bash
   docker exec -it php-app bash
   ```

3. **Install Laravel dependencies**:

   ```bash
   composer install
   npm install
   npm run dev
   ```

4. **Configure Laravel environment**:

   ```bash
   cp .env.example .env
   php artisan key:generate
   php artisan migrate
   php artisan db:seed
   ```

5. **Fix permissions**:
   ```bash
   chmod -R 777 storage bootstrap/cache
   chown -R www-data:www-data .
   ```

**Access your application**: `http://localhost:8009`

### Node.js Applications

**Development Setup**:

1. Place your Node.js project in `./containers/node-app/`

2. **Access the Node container**:

   ```bash
   docker exec -it node bash
   ```

3. **Install dependencies and run**:
   ```bash
   npm install
   npm run dev
   ```

**Custom port configuration**: Edit `docker-compose.override.yaml` to change the exposed port

**Access your application**: `http://localhost:3000`

### MongoDB

**Connection Details**:

- **Host**: `localhost`
- **Port**: `27019`
- **Username**: `root`
- **Password**: `password`

**Connect using mongosh**:

```bash
mongosh --port 27019 --username root --password password
```

**Web Interface**: Access Mongo Express at `http://localhost:8091`

- Username: `mexpress`
- Password: `mexpress`

**Data Persistence**: Data is stored in `.docker/mgdata/db/`

### SQL Server

**Connection Details**:

- **Host**: `localhost`
- **Port**: `1434`
- **Username**: `sa`
- **Password**: `yourStrong123Password`

**Connect using sqlcmd** (from within container):

```bash
docker exec -it sqlserver /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P yourStrong123Password
```

**Data Persistence**: Data is stored in `.docker/sqldata/data/`

**Additional Resources**: [SQL Server in Docker Guide](https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-docker-container-configure)

---

## Platform-Specific Setup

### WSL2 Setup

#### Backup and Restore WSL Distribution

**Backup WSL**:

1. Locate your WSL virtual disk:
   ```
   C:\Users\<username>\AppData\Local\Packages\CanonicalGroupLimited.Ubuntu_79rhkp1fndgsc\LocalState\ext4.vhdx
   ```
2. Copy this file to a safe location

**Restore WSL**:

1. Shutdown WSL:
   ```bash
   wsl --shutdown
   ```
2. Replace the `ext4.vhdx` file with your backup
3. Restart WSL:
   ```bash
   wsl
   ```

#### WSL Performance Optimization

For better Docker performance in WSL2:

1. **Create/Edit `.wslconfig`** in `C:\Users\<username>\.wslconfig`:

   ```ini
   [wsl2]
   memory=8GB
   processors=4
   swap=2GB
   ```

2. **Restart WSL**:
   ```powershell
   wsl --shutdown
   ```

### MacOS Setup

**Prerequisites**:

- Install [Docker Desktop for Mac](https://www.docker.com/products/docker-desktop)
- Ensure Docker has sufficient resources (Settings → Resources)

**Potential Adjustments**:

1. File permissions may differ - adjust `chown` commands in `init.sh`
2. Volume mount paths should work as-is
3. For Apple Silicon (M1/M2), ensure multi-platform support is enabled

---

## Advanced Configuration

### Environment Variables

The `.env` file controls user permissions and security settings:

```dotenv
UID=1000                    # User ID for Node.js container
GID=1000                    # Group ID for Node.js container
SSH_USER=deploy             # SSH username for .NET container
SSH_PASSWORD=deploypassword # SSH password for .NET container
CRT_PASSWORD=A_1234567a     # SSL certificate password
```

**Security Note**: Change default passwords in production environments!

### Custom Overrides

The `docker-compose.override.yaml` file allows you to customize services without modifying the main compose file:

**Example - Change Node.js port**:

```yaml
version: "3.8"

services:
  node:
    ports:
      - "4000:3000" # Map host:4000 to container:3000
```

**Example - Add environment variables**:

```yaml
services:
  php-app:
    environment:
      - APP_ENV=local
      - APP_DEBUG=true
```

---

## Development Tools

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

3. **Test connection**:
   ```bash
   ssh -T git@github.com
   ```

---

### Configure GPG Keys

Sign commits with GPG for verified badges on GitHub:

1. **Check for existing keys**:

   ```bash
   gpg --list-secret-keys --keyid-format=long
   ```

2. **Generate new GPG key** (if needed):

   ```bash
   gpg --full-generate-key
   ```

   - Select: RSA and RSA
   - Key size: 4096
   - Expiration: 0 (no expiration) or set as preferred
   - Enter your name and email

3. **Get your key ID**:

   ```bash
   gpg --list-secret-keys --keyid-format=long
   ```

   Look for the line starting with `sec` - the key ID is after the `/`

4. **Export public key**:

   ```bash
   gpg --armor --export YOUR_KEY_ID
   ```

5. **Add to GitHub**: Paste at [GitHub GPG Keys](https://github.com/settings/keys)

6. **Configure Git to use GPG**:

   ```bash
   git config --global user.signingkey YOUR_KEY_ID
   git config --global commit.gpgsign true
   git config --global gpg.program gpg
   ```

7. **Verify signing**:
   ```bash
   echo "test" | gpg --clearsign
   ```

---

## Troubleshooting

### Common Issues

**Port conflicts**:

```bash
# Check what's using a port
sudo lsof -i :3000
# Or on Windows WSL
netstat -ano | findstr :3000
```

**Permission issues**:

```bash
# Reset permissions for Docker volumes
sudo chown -R $USER:$USER .docker
sudo chmod -R 777 .docker
```

**Container won't start**:

```bash
# Check logs
docker logs <container-name>

# Rebuild container
docker compose up -d --build --force-recreate <service-name>
```

**Database connection refused**:

- Ensure the container is running: `docker ps`
- Check you're using the correct port (see Available Services table)
- For connections from your host, use `localhost`
- For connections between containers, use the service name (e.g., `mongo`, `mydb`)

### Useful Commands

```bash
# Stop all containers
docker compose down

# Stop and remove volumes (⚠️ deletes data)
docker compose down -v

# View container logs
docker compose logs -f <service-name>

# Access container shell
docker exec -it <container-name> bash

# Rebuild specific service
docker compose up -d --build <service-name>

# View resource usage
docker stats
```

---

## Project Structure

```
development-environment/
├── .docker/                     # Docker persistent data
│   ├── mgdata/                  # MongoDB data
│   ├── mydata/                  # MySQL/MariaDB data
│   ├── pgdata/                  # PostgreSQL data
│   ├── sqldata/                 # SQL Server data
│   ├── pgadmin/                 # pgAdmin config
│   ├── dotnet-deploy/           # .NET Dockerfile & config
│   ├── php/                     # PHP Dockerfile
│   ├── nginx/                   # Nginx Dockerfile
│   ├── node/                    # Node.js Dockerfile
│   ├── mysql/                   # MySQL Dockerfile
│   └── sqlserver/               # SQL Server Dockerfile
├── containers/                  # Your application code
│   ├── dotnet-app/             # .NET projects
│   ├── php-app/                # PHP/Laravel projects
│   ├── node-app/               # Node.js projects
│   └── client/apps/            # Static sites/SPAs
├── .env.example                # Environment variables template
├── docker-compose.example.yaml # Docker Compose template
├── docker-compose.override.yaml# Custom service overrides
├── init.sh                     # Automated setup script
└── README.md                   # This file
```

---

## Contributing

Contributions are welcome! Here are some ways you can help:

- 🐛 Report bugs or issues
- 💡 Suggest new services or improvements
- 📝 Improve documentation
- 🔧 Submit pull requests

---

## License

This project is open source and available for personal and commercial use. Feel free to modify and distribute as needed.

---

## Additional Resources

- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [WSL2 Documentation](https://docs.microsoft.com/en-us/windows/wsl/)
- [SQL Server on Linux](https://learn.microsoft.com/en-us/sql/linux/)

---

**Happy Coding! 🚀**

```

```
