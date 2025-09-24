FROM mcr.microsoft.com/devcontainers/python:3.11-bullseye

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    wget \
    unzip \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    gnupg \
    lsb-release \
    tree \
    jq \
    vim \
    nano \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install GitHub CLI
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    && chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && apt-get update \
    && apt-get install gh -y \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js LTS
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# Install uv package manager
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

# Add uv to PATH
ENV PATH="/root/.cargo/bin:$PATH"

# Switch to vscode user
USER vscode

# Install uv for vscode user and add to PATH
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
ENV PATH="/home/vscode/.cargo/bin:/home/vscode/.local/bin:$PATH"

# Install Git Credential Manager
RUN wget -q https://github.com/git-ecosystem/git-credential-manager/releases/download/v2.6.1/gcm-linux_amd64.2.6.1.deb \
    && sudo dpkg -i gcm-linux_amd64.2.6.1.deb || sudo apt-get install -f -y \
    && rm -f gcm-linux_amd64.2.6.1.deb \
    && git config --global credential.helper manager

# Pre-install Spec-Kit CLI (this might fail if network issues persist, but setup.sh will retry)
RUN /home/vscode/.cargo/bin/uv tool install specify-cli --from git+https://github.com/github/spec-kit.git || echo "Spec-Kit CLI installation will be retried in setup.sh"

# Set up shell configuration
RUN echo 'export PATH="/home/vscode/.cargo/bin:/home/vscode/.local/bin:$PATH"' >> /home/vscode/.bashrc \
    && echo 'alias spec="specify"' >> /home/vscode/.bashrc \
    && echo 'alias spec-init="specify init"' >> /home/vscode/.bashrc \
    && echo 'alias spec-check="specify check"' >> /home/vscode/.bashrc