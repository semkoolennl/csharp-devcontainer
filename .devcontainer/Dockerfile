FROM ubuntu:20.04

# Set timezone environment variable to avoid timezone prompt during package installation
ENV TZ=Europe/Amsterdam

# Update the package lists
RUN apt-get update && \
    ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    apt-get install -y tzdata wget curl git

# Install C++ build tools and dependencies
RUN apt-get install -y build-essential cmake libgtk-3-dev libboost-all-dev libssl-dev libcurl4-openssl-dev

# Install C++ dependencies
RUN wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN rm packages-microsoft-prod.deb
RUN apt-get update && \
    apt-get install -y dotnet-sdk-7.0 aspnetcore-runtime-7.0

# Create a non-root user matching the host user's UID/GID
ARG USERNAME=devuser
ARG USER_UID=1000
ARG USER_GID=1000

# Install sudo
RUN apt-get update && \
    apt-get install -y sudo && \
    apt-get clean

# Add the user with sudo privileges based on the build argument USERNAME
RUN groupadd devuser
RUN useradd --uid $USER_UID --gid devuser -m $USERNAME
RUN echo "$USERNAME ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

COPY scripts /scripts
RUN chmod +x -R /scripts

USER $USERNAME

ENTRYPOINT ["/scripts/entrypoint.sh"]