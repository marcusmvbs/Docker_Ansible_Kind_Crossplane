FROM ubuntu:22.04

LABEL maintainer="Marcus Barros da Silva <marcus.mvbs@gmail.com>"

ENV DEBIAN_FRONTEND=noninteractive

RUN echo "Updating package index..." && \
    apt-get update && \ 
    echo "Installing required tools..." && \
    apt-get install -y --no-install-recommends \
    gnupg curl wget ca-certificates apt-utils apt-transport-https \
    openssh-server \
    python3 python3-pip python3-apt \
    ansible \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install --no-cache-dir --upgrade pip && \
    ansible-galaxy collection install community.general community.kubernetes

# Install Docker
RUN curl -fsSL https://get.docker.com -o get-docker.sh && \
    sh get-docker.sh && \
    rm get-docker.sh

RUN mkdir -p /ansible /kind-config

# Storing Ansible, Kind, Crossplane-aws, credentials config files
COPY Ansible/ /ansible/
COPY Kind/ /kind-config/
COPY .creds.txt /kind-config/charts/dev/aws/creds.txt
RUN chmod +x /kind-config/add_aws_bucket.sh

WORKDIR /kind-config/

# Set up an entrypoint script to initialize Kind cluster
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Expose any necessary ports
EXPOSE 22 6443

# Set the entrypoint script
ENTRYPOINT ["entrypoint.sh"]