#!/bin/bash
set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

APP_DIR="/app"
INITIALIZED_FLAG="$APP_DIR/.node_initialized"

echo -e "${YELLOW}[Node.js Container] Starting...${NC}"

# Check if Node app is already initialized
if [ ! -f "$INITIALIZED_FLAG" ]; then
    echo -e "${YELLOW}[Node.js] No existing application found. Creating sample Express app...${NC}"
    
    cd $APP_DIR
    
    # Initialize package.json if it doesn't exist
    if [ ! -f "package.json" ]; then
        cat > package.json <<EOF
{
  "name": "node-dev-app",
  "version": "1.0.0",
  "description": "Node.js development environment",
  "main": "index.js",
  "scripts": {
    "start": "node index.js",
    "dev": "nodemon index.js"
  },
  "dependencies": {
    "express": "^4.18.2"
  },
  "devDependencies": {
    "nodemon": "^3.0.1"
  }
}
EOF
    fi
    
    # Create sample Express server if index.js doesn't exist
    if [ ! -f "index.js" ]; then
        cat > index.js <<EOF
const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;

app.get('/', (req, res) => {
  res.send(\`
    <!DOCTYPE html>
    <html>
    <head>
      <title>Node.js Dev Environment</title>
      <style>
        body {
          font-family: Arial, sans-serif;
          max-width: 800px;
          margin: 50px auto;
          padding: 20px;
          background: #f5f5f5;
        }
        .container {
          background: white;
          padding: 30px;
          border-radius: 8px;
          box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        h1 { color: #68a063; }
        .info { background: #e8f5e9; padding: 15px; border-radius: 4px; margin: 20px 0; }
        code { background: #f5f5f5; padding: 2px 6px; border-radius: 3px; }
      </style>
    </head>
    <body>
      <div class="container">
        <h1>🚀 Node.js Development Environment</h1>
        <p>Your Node.js container is running successfully!</p>
        
        <div class="info">
          <strong>Container Details:</strong><br>
          Node Version: \${process.version}<br>
          Port: \${PORT}<br>
          Environment: \${process.env.NODE_ENV || 'development'}
        </div>
        
        <h2>Quick Start</h2>
        <ol>
          <li>Your application files are in <code>/app</code></li>
          <li>Edit <code>index.js</code> to customize this server</li>
          <li>Run <code>npm install [package]</code> to add dependencies</li>
          <li>Use <code>npm run dev</code> for auto-reload with nodemon</li>
        </ol>
        
        <h2>Sample Routes</h2>
        <ul>
          <li><a href="/api/status">/api/status</a> - API status endpoint</li>
          <li><a href="/api/info">/api/info</a> - System information</li>
        </ul>
      </div>
    </body>
    </html>
  \`);
});

app.get('/api/status', (req, res) => {
  res.json({
    status: 'ok',
    timestamp: new Date().toISOString(),
    uptime: process.uptime()
  });
});

app.get('/api/info', (req, res) => {
  res.json({
    nodeVersion: process.version,
    platform: process.platform,
    memory: process.memoryUsage(),
    env: process.env.NODE_ENV || 'development'
  });
});

app.listen(PORT, '0.0.0.0', () => {
  console.log(\`✓ Server running on http://localhost:\${PORT}\`);
});
EOF
    fi
    
    # Install dependencies
    echo -e "${YELLOW}[Node.js] Installing dependencies...${NC}"
    npm install
    
    # Create initialized flag
    touch "$INITIALIZED_FLAG"
    
    echo -e "${GREEN}[Node.js] ✓ Sample Express application created!${NC}"
    echo -e "${GREEN}[Node.js] ✓ Access your application at http://localhost:3000${NC}"
else
    echo -e "${GREEN}[Node.js] ✓ Existing application found.${NC}"
fi

# Start the application
echo -e "${GREEN}[Node.js] Starting application...${NC}"
exec npm start
