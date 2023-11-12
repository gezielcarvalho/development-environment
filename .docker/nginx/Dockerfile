# Use the official Ubuntu as a parent image
FROM ubuntu:latest

# Install Nginx
RUN apt-get update && apt-get install -y nginx sudo vim
RUN useradd -m ubuntu
RUN usermod -aG sudo ubuntu
RUN echo 'ubuntu:A!234567a' | chpasswd

WORKDIR /home/ubuntu
RUN mkdir -p /home/ubuntu/apps && chown -R ubuntu:www-data /home/ubuntu/apps && chmod -R 775 /home/ubuntu/apps && chmod +x /home/ubuntu

# Expose port 80 for Nginx
EXPOSE 80

# Start Nginx when the container runs
CMD ["nginx", "-g", "daemon off;"]
# FROM ubuntu:22.04

# RUN curl -sL https://deb.nodesource.com/setup_18.x | bash -

# RUN apt-get update

# # https://github.com/docker-library/php/issues/221
# RUN apt-get install -y nodejs libcurl4-openssl-dev pkg-config libssl-dev libpq-dev libzip-dev zip libgmp-dev libmcrypt-dev libmagickwand-dev --no-install-recommends 

# # JPEG - https://stackoverflow.com/a/52892313/2190689
# RUN apt-get update && apt-get install -y \
#         libfreetype6-dev \
#         libjpeg62-turbo-dev \
#         libpng-dev \
#     && docker-php-ext-configure gd --with-freetype --with-jpeg \
#     && docker-php-ext-install -j$(nproc) gd