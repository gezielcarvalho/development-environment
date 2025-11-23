#!/bin/bash
set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

APP_DIR="/home/${SSH_USER}/app"
INITIALIZED_FLAG="$APP_DIR/.dotnet_initialized"

echo -e "${YELLOW}[.NET Container] Starting...${NC}"

# Start SSH service in background
/usr/sbin/sshd

# Check if .NET app is already initialized
if [ ! -f "$INITIALIZED_FLAG" ]; then
    echo -e "${YELLOW}[.NET] No existing application found. Creating sample ASP.NET Core app...${NC}"
    
    cd $APP_DIR
    
    # Create a new ASP.NET Core Web API project if it doesn't exist
    if [ ! -f "Program.cs" ]; then
        dotnet new webapi -n DevApp --no-https
        mv DevApp/* .
        mv DevApp/.* . 2>/dev/null || true
        rmdir DevApp
        
        # Update port configuration to use environment variables
        cat > Properties/launchSettings.json <<EOF
{
  "\$schema": "http://json.schemastore.org/launchsettings.json",
  "profiles": {
    "http": {
      "commandName": "Project",
      "dotnetRunMessages": true,
      "launchBrowser": false,
      "applicationUrl": "http://0.0.0.0:5000",
      "environmentVariables": {
        "ASPNETCORE_ENVIRONMENT": "Development"
      }
    }
  }
}
EOF
    fi
    
    # Set proper ownership
    chown -R ${SSH_USER}:${SSH_USER} $APP_DIR
    chmod -R 755 $APP_DIR
    
    # Create initialized flag
    touch "$INITIALIZED_FLAG"
    
    echo -e "${GREEN}[.NET] ✓ Sample ASP.NET Core Web API created!${NC}"
    echo -e "${GREEN}[.NET] ✓ Access your API at http://localhost:5008${NC}"
    echo -e "${GREEN}[.NET] ✓ SSH access: ssh ${SSH_USER}@localhost -p 2222${NC}"
else
    echo -e "${GREEN}[.NET] ✓ Existing application found.${NC}"
fi

# Build and run the application
cd $APP_DIR
if [ -f "*.csproj" ] || [ -f "Program.cs" ]; then
    echo -e "${YELLOW}[.NET] Building application...${NC}"
    dotnet build
    
    echo -e "${GREEN}[.NET] Starting application...${NC}"
    exec dotnet run
else
    echo -e "${YELLOW}[.NET] No .NET project found. SSH server is running.${NC}"
    # Keep SSH running
    exec tail -f /dev/null
fi
