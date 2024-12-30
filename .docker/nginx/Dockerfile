# Use the official Ubuntu as a parent image
FROM ubuntu:24.04

# Install Nginx
RUN apt-get update && apt-get install -y nginx sudo vim
RUN usermod -aG sudo ubuntu
RUN echo 'ubuntu:A!234567a' | chpasswd

COPY default.conf /etc/nginx/sites-available/default

WORKDIR /home/ubuntu
RUN mkdir -p /home/ubuntu/apps && chown -R ubuntu:www-data /home/ubuntu/apps && chmod -R 775 /home/ubuntu/apps && chmod +x /home/ubuntu

# Expose port 80 for Nginx
EXPOSE 80

# Start Nginx when the container runs
CMD ["nginx", "-g", "daemon off;"]