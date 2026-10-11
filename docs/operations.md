# Operations

## Current posture

Local development only. The environment may create containers, local volumes, and configuration files on a developer workstation. Read the README before any action; the initializer overwrites `.env` and Compose files.

## Data and credential boundary

Example usernames, passwords, certificates, SSH settings, and exposed ports are instructional defaults. Do not reuse them in shared environments or commit real credentials. Treat `.env` and local volumes as potentially sensitive.

## Destructive commands

Commands such as `docker compose down -v`, reinitialization, and file/volume cleanup can remove local data or overwrite configuration. Confirm targets, back up needed data/configuration, and obtain explicit approval before using them.

No production deployment, on-call, backup, or monitoring posture is supported.
