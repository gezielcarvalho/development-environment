# Use an official Node.js image
FROM node:18

# Set the working directory inside the container
WORKDIR /app

# Create the app directory and set permissions
RUN mkdir -p /app && chown -R 1000:1000 /app

# Switch to a non-root user
USER 1000:1000

# Default command to keep the container running
# Copy entrypoint script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Use custom entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
