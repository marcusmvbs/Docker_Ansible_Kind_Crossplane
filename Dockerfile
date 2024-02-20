FROM ubuntu:22.04

LABEL maintainer="Marcus Barros da Silva <marcus.mvbs@gmail.com>"

ENV DEBIAN_FRONTEND=noninteractive

# Update package index and install required packages
RUN echo "Updating package index..." && \
    apt-get update && \ 
    apt-get install -y --no-install-recommends \
    gnupg curl wget ca-certificates apt-utils \
    openssh-server \
    python3 python3-pip \
    ansible \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip and install ansible via pip
RUN pip3 install --no-cache-dir --upgrade pip && \
    ansible --version

# Install Docker
RUN curl -fsSL https://get.docker.com -o get-docker.sh && \
    sh get-docker.sh && \
    rm get-docker.sh && \
    docker --version

# Install Kind
ENV KIND_VERSION=v0.12.0
RUN curl -Lo /usr/local/bin/kind "https://kind.sigs.k8s.io/dl/${KIND_VERSION}/kind-linux-amd64" && \
    chmod +x /usr/local/bin/kind && \
    kind version

# Install kubectl
ENV KUBECTL_VERSION=v1.24.1
RUN wget -O /usr/local/bin/kubectl "https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl" && \
    chmod +x /usr/local/bin/kubectl && \
    kubectl version --client --short

# Install Helm
ENV HELM_VERSION=v3.7.0
RUN wget -q "https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz" -O /tmp/helm.tar.gz && \
    tar -C /tmp -zxvf /tmp/helm.tar.gz && \
    mv /tmp/linux-amd64/helm /usr/local/bin/helm && \
    rm -rf /tmp/linux-amd64 /tmp/helm.tar.gz && \
    helm version --short

# Configure SSH server
RUN echo 'root:password' | chpasswd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    ssh-keygen -A && \
    chmod 700 /etc/ssh
#    chmod 600 /etc/ssh/*_key

# Storing Kind cluster config
RUN mkdir -p /kind-config
COPY kind-config.yaml /kind-config

# Set up an entrypoint script to initialize Kind cluster
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Expose any necessary ports
EXPOSE 22 6443

# Set the entrypoint script
ENTRYPOINT ["entrypoint.sh"]