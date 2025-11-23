#!/bin/bash
set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

APP_DIR="/var/www/html"
INITIALIZED_FLAG="$APP_DIR/.laravel_initialized"

echo -e "${YELLOW}[PHP-Laravel Container] Starting...${NC}"

# Check if Laravel is already initialized
if [ ! -f "$INITIALIZED_FLAG" ]; then
    echo -e "${YELLOW}[Laravel] No existing installation found. Creating fresh Laravel application...${NC}"
    echo -e "${YELLOW}[Laravel] This may take 2-3 minutes on first run...${NC}"
    
    # Clear the directory (except for hidden files like .gitkeep)
    rm -rf $APP_DIR/*
    
    # Create Laravel project in a temp directory
    cd /tmp
    composer create-project --prefer-dist laravel/laravel laravel-temp
    
    # Move Laravel files to the app directory
    mv /tmp/laravel-temp/* $APP_DIR/
    mv /tmp/laravel-temp/.* $APP_DIR/ 2>/dev/null || true
    
    # Clean up temp directory
    rm -rf /tmp/laravel-temp
    
    cd $APP_DIR
    
    # Set proper permissions
    chown -R www-data:www-data $APP_DIR
    chmod -R 755 $APP_DIR
    chmod -R 775 $APP_DIR/storage $APP_DIR/bootstrap/cache
    
    # Generate application key if not exists
    if ! grep -q "APP_KEY=base64:" .env; then
        echo -e "${YELLOW}[Laravel] Generating application key...${NC}"
        php artisan key:generate --ansi
    fi
    
    # Install npm dependencies
    echo -e "${YELLOW}[Laravel] Installing npm dependencies...${NC}"
    npm install
    
    # Build assets
    echo -e "${YELLOW}[Laravel] Building frontend assets...${NC}"
    npm run build
    
    # Create initialized flag
    touch "$INITIALIZED_FLAG"
    
    echo -e "${GREEN}[Laravel] ✓ Fresh Laravel installation complete!${NC}"
    echo -e "${GREEN}[Laravel] ✓ Access your application at http://localhost:8009${NC}"
else
    echo -e "${GREEN}[Laravel] ✓ Existing installation found. Skipping setup.${NC}"
    
    # Ensure proper permissions on each startup
    chown -R www-data:www-data $APP_DIR
    chmod -R 775 $APP_DIR/storage $APP_DIR/bootstrap/cache 2>/dev/null || true
fi

# Start Apache in foreground
echo -e "${GREEN}[Apache] Starting web server...${NC}"
exec apache2-foreground
