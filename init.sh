#!/bin/bash

# Log message function
log() {
  echo -e "[INFO] $1"
}

# Error message function
error() {
  echo -e "[ERROR] $1"
}

# Confirmation prompt
confirm() {
  read -p "$1 (y/n): " choice
  case "$choice" in
    y|Y ) true ;;
    * ) false ;;
  esac
}

# Paths to required files
ENV_EXAMPLE=".env.example"
ENV_FILE=".env"
DOCKER_COMPOSE_EXAMPLE="docker-compose.example.yaml"
DOCKER_COMPOSE_FILE="docker-compose.yaml"

# Required directories
REQUIRED_DIRECTORIES=(
  "./.docker/sqldata/data"
  "./.docker/mgdata/db"
  "./.docker/mgdata/dev.archive"
  "./.docker/mgdata/production"
  "./.docker/mydata"
  "./.docker/pgdata"
  "./.docker/pgadmin"
)

# Warn user about resetting configurations
log "This script will reset modifications in $ENV_FILE and $DOCKER_COMPOSE_FILE."
if ! confirm "Do you want to continue?"; then
  log "Operation canceled."
  exit 0
fi

# Copy .env.example to .env
if [ -f "$ENV_EXAMPLE" ]; then
  cp -f "$ENV_EXAMPLE" "$ENV_FILE"
  log "Copied $ENV_EXAMPLE to $ENV_FILE."
else
  error "$ENV_EXAMPLE not found. Aborting."
  exit 1
fi

# Copy docker-compose.example.yaml to docker-compose.yaml
if [ -f "$DOCKER_COMPOSE_EXAMPLE" ]; then
  cp -f "$DOCKER_COMPOSE_EXAMPLE" "$DOCKER_COMPOSE_FILE"
  log "Copied $DOCKER_COMPOSE_EXAMPLE to $DOCKER_COMPOSE_FILE."
else
  error "$DOCKER_COMPOSE_EXAMPLE not found. Aborting."
  exit 1
fi

# Create required directories and set permissions
log "Creating required directories and setting permissions..."
for dir in "${REQUIRED_DIRECTORIES[@]}"; do
  if [ ! -d "$dir" ]; then
    mkdir -p "$dir"
    log "Created directory: $dir"
  fi
  # Set ownership to the current user and permissions
  sudo chown -R $USER:$USER "$dir"
  sudo chmod -R 777 "$dir"
  log "Set permissions for: $dir"
done

# Start Docker containers
log "Starting Docker containers..."
docker compose up -d
if [ $? -eq 0 ]; then
  log "Containers started successfully."
else
  error "Failed to start containers."
  exit 1
fi

log "Initialization complete."
