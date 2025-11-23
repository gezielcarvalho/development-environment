# Use the official .NET 8 SDK image
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS base

# Install SSH server
RUN apt-get update && apt-get install -y openssh-server && \
    mkdir /var/run/sshd

# Declare build arguments for user and password
ARG SSH_USER
ARG SSH_PASSWORD
ARG CRT_PASSWORD

# Create a deploy user and set up SSH access
RUN useradd -m -s /bin/bash $SSH_USER && \
    echo "$SSH_USER:$SSH_PASSWORD" | chpasswd && \
    mkdir /home/$SSH_USER/.ssh && chmod 700 /home/$SSH_USER/.ssh && \
    mkdir /home/$SSH_USER/app && chmod 700 /home/$SSH_USER/.ssh && \
    chown $SSH_USER:$SSH_USER /home/$SSH_USER/.ssh && \
    chown $SSH_USER:$SSH_USER /home/$SSH_USER/app

RUN rm -f /usr/local/share/ca-certificates/localhost.pfx
# Generate a self-signed development certificate inside the container
RUN dotnet dev-certs https --clean && \
    dotnet dev-certs https -ep /usr/local/share/ca-certificates/localhost.pfx -p "$CRT_PASSWORD" && \
    dotnet dev-certs https --trust

# Copy entrypoint script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Expose ports for SSH and HTTP
EXPOSE 22 5000

# Set working directory
WORKDIR /home/$SSH_USER/app

# Use custom entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
