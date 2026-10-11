# Architecture

```text
Developer workstation (Ubuntu / WSL2 / compatible Docker host)
  |
  v
Docker Compose local network
  +-- application runtimes: .NET, PHP/Laravel, Node.js, Nginx
  +-- data services: SQL Server, MongoDB, MariaDB, PostgreSQL
  +-- local administration UIs: Mongo Express, phpMyAdmin, pgAdmin
  +-- persisted local data under .docker/
```

The root README describes ports, service names, templates, and overrides. `.env.example` and `docker-compose.example.yaml` seed a local configuration; they do not establish approved credentials, access control, or network policy for a shared environment.
