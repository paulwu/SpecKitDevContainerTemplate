# Use Ubuntu as base image to ensure Linux environment compatibility
FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1
ENV UV_SYSTEM_PYTHON=1

# Install system dependencies
RUN apt-get update && apt-get install -y \
    # Build essentials
    build-essential \
    curl \
    wget \
    git \
    unzip \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    gnupg \
    lsb-release \
    # Python development
    python3.11 \
    python3.11-dev \
    python3.11-venv \
    python3-pip \
    # Development tools
    vim \
    nano \
    jq \
    tree \
    htop \
    # Network tools
    net-tools \
    iputils-ping \
    # SQLite for local development
    sqlite3 \
    libsqlite3-dev \
    # Additional tools for AI agent integration
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/*

# Set Python 3.11 as default
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.11 1 \
    && update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 1

# Install uv package manager (required for Spec-Kit)
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
ENV PATH="/root/.cargo/bin:$PATH"

# Create non-root user for development
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Add uv to PATH for all users
RUN echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> /etc/bash.bashrc \
    && echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> /etc/zsh/zshrc

# Switch to vscode user for remaining installations
USER $USERNAME

# Install uv for the vscode user
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
ENV PATH="/home/vscode/.cargo/bin:$PATH"

# Install Spec-Kit CLI tool
RUN uv tool install specify-cli --from git+https://github.com/github/spec-kit.git

# Install AI coding agent CLI tools (where available)
# Note: Some tools may require manual setup or API keys

# Install Claude Code CLI (Anthropic's tool)
RUN curl -fsSL https://claude.ai/cli/install.sh | bash || echo "Claude CLI installation failed - may require manual setup"

# Install Gemini CLI (Google's tool)
RUN npm install -g @google-ai/generativelanguage || echo "Gemini CLI installation failed - may require manual setup"

# Install opencode CLI
RUN npm install -g @opencode/cli || echo "opencode CLI installation failed - may require manual setup"

# Note: Other AI tools like Cursor and Qwen may require different installation methods
# and are often IDE-specific or require separate downloads

# Create workspace directory
WORKDIR /workspaces

# Set up Git configuration template (users will need to customize)
RUN git config --global init.defaultBranch main \
    && git config --global pull.rebase false \
    && git config --global user.name "DevContainer User" \
    && git config --global user.email "user@example.com"

# Create useful aliases
RUN echo 'alias ll="ls -la"' >> ~/.bashrc \
    && echo 'alias spec="specify"' >> ~/.bashrc \
    && echo 'alias ..="cd .."' >> ~/.bashrc

# Add helpful prompt with Spec-Kit info
RUN echo 'export PS1="\[\033[36m\][spec-kit]\[\033[0m\] \u@\h:\w\$ "' >> ~/.bashrc

# Set the default command
CMD ["/bin/bash"]