# Use an official Node.js image
FROM node:18

# Set the working directory inside the container
WORKDIR /app

# Create the app directory and set permissions
RUN mkdir -p /app && chown -R 1000:1000 /app

# Switch to a non-root user
USER 1000:1000

# Default command to keep the container running
CMD ["bash"]