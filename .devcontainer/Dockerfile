# Use the official Microsoft DevContainers Universal image as base
FROM mcr.microsoft.com/devcontainers/universal:2

# Set the working directory
WORKDIR /workspaces

# Install additional tools for Spec-Kit development and testing
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
        curl \
        wget \
        git \
        jq \
        tree \
        htop \
        vim \
        nano \
        build-essential \
        pkg-config \
        libssl-dev \
        sqlite3 \
        postgresql-client \
        redis-tools \
        netcat \
        telnet \
        unzip \
        zip \
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# Install additional Python packages for testing and specification work
RUN pip3 install --no-cache-dir \
    pytest \
    pytest-cov \
    black \
    flake8 \
    mypy \
    requests \
    pydantic \
    fastapi \
    uvicorn \
    jsonschema \
    pyyaml \
    behave \
    selenium \
    httpx

# Install additional Node.js packages globally
RUN npm install -g \
    @types/node \
    typescript \
    ts-node \
    jest \
    @jest/globals \
    eslint \
    prettier \
    ajv \
    ajv-cli \
    json-schema-to-typescript \
    openapi-generator-cli \
    @apidevtools/swagger-parser \
    newman \
    @postman/newman-reporter-html

# Install Go tools
RUN go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest \
    && go install golang.org/x/tools/cmd/goimports@latest \
    && go install github.com/swaggo/swag/cmd/swag@latest

# Create a non-root user for development
ARG USERNAME=codespace
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create the user if it doesn't exist
RUN if ! id -u $USERNAME > /dev/null 2>&1; then \
        groupadd --gid $USER_GID $USERNAME \
        && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
        && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
        && chmod 0440 /etc/sudoers.d/$USERNAME; \
    fi

# Switch to the non-root user
USER $USERNAME

# Set up shell environment
RUN echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> ~/.bashrc \
    && echo 'alias ll="ls -la"' >> ~/.bashrc \
    && echo 'alias la="ls -la"' >> ~/.bashrc \
    && echo 'echo "Welcome to Spec-Kit Test Environment!"' >> ~/.bashrc