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
log "Starting/Building Docker containers..."
docker compose up -d --build
if [ $? -eq 0 ]; then
  log "Containers started successfully."
else
  error "Failed to start containers."
  exit 1
fi

# Change permissions for 'containers' folder
CONTAINERS_DIR="./containers"
if [ -d "$CONTAINERS_DIR" ]; then
  log "Updating permissions for the 'containers' folder..."
  sudo chown -R $USER:$USER "$CONTAINERS_DIR"
  sudo chmod -R 777 "$CONTAINERS_DIR"
  log "Permissions updated for: $CONTAINERS_DIR"
else
  log "'containers' folder not found. Skipping."
fi

# Fix line endings for entrypoint scripts
log "Fixing line endings for entrypoint scripts..."
for script in .docker/*/entrypoint.sh; do
  if [ -f "$script" ]; then
    dos2unix "$script" 2>/dev/null || sed -i 's/\r$//' "$script"
    chmod +x "$script"
    log "Fixed: $script"
  fi
done

# Set permissions for the application inside the dotnet container
docker exec dotnet-app chown -R deploy:deploy /home/deploy/app
docker exec dotnet-app chmod -R 755 /home/deploy/app

#!/bin/bash

# Copy the certificate from the container to WSL
docker cp dotnet-app:/usr/local/share/ca-certificates/localhost.pfx ./localhost.pfx

echo "[INFO] Certificate copied to your project."
echo "[INFO] Please import 'localhost.pfx' into Windows Trusted Root Certification Authorities."


log "Initialization complete."
