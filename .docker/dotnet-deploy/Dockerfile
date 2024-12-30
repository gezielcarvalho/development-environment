# Use the official .NET 8 SDK image
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS base

# Install SSH server
RUN apt-get update && apt-get install -y openssh-server && \
    mkdir /var/run/sshd

# Declare build arguments for user and password
ARG SSH_USER
ARG SSH_PASSWORD

# Create a deploy user and set up SSH access
RUN useradd -m -s /bin/bash $SSH_USER && \
    echo "$SSH_USER:$SSH_PASSWORD" | chpasswd && \
    mkdir /home/$SSH_USER/.ssh && chmod 700 /home/$SSH_USER/.ssh && \
    mkdir /home/$SSH_USER/app && chmod 700 /home/$SSH_USER/.ssh && \
    chown $SSH_USER:$SSH_USER /home/$SSH_USER/.ssh && \
    chown $SSH_USER:$SSH_USER /home/$SSH_USER/app

# Expose ports for SSH
EXPOSE 22

# Start the SSH service
CMD ["/usr/sbin/sshd", "-D"]
