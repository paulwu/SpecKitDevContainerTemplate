#!/bin/bash
set -e

echo "🌱 Setting up Spec-Kit Development Environment"
echo "============================================="

# Update system packages
echo "📦 Updating system packages..."
sudo apt-get update -y
sudo apt-get upgrade -y

# Install essential build tools and utilities
echo "🔧 Installing development tools..."
sudo apt-get install -y \
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
    git

# Install GitHub CLI
echo "📦 Installing GitHub CLI..."
if ! command -v gh &> /dev/null; then
    # Add GitHub CLI repository
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    && sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && sudo apt-get update \
    && sudo apt-get install gh -y
    echo "✅ GitHub CLI installed successfully"
else
    echo "✅ GitHub CLI already installed"
fi

# Install Node.js LTS
echo "📦 Installing Node.js LTS..."
if ! command -v node &> /dev/null; then
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
    sudo apt-get install -y nodejs
    echo "✅ Node.js installed successfully"
else
    echo "✅ Node.js already installed" 
fi

# Install Git Credential Manager (as recommended in Spec-Kit docs)
echo "🔐 Installing Git Credential Manager..."
if ! command -v git-credential-manager &> /dev/null; then
    echo "Downloading Git Credential Manager v2.6.1..."
    wget -q https://github.com/git-ecosystem/git-credential-manager/releases/download/v2.6.1/gcm-linux_amd64.2.6.1.deb
    echo "Installing Git Credential Manager..."
    sudo dpkg -i gcm-linux_amd64.2.6.1.deb || sudo apt-get install -f -y
    echo "Configuring Git to use GCM..."
    git config --global credential.helper manager
    echo "Cleaning up..."
    rm -f gcm-linux_amd64.2.6.1.deb
    echo "✅ Git Credential Manager installed successfully"
else
    echo "✅ Git Credential Manager already installed"
fi

# Install uv (Python package manager)
echo "📦 Installing uv package manager..."
if ! command -v uv &> /dev/null; then
    curl -LsSf https://astral.sh/uv/install.sh | sh
    # Add uv to PATH for current session
    export PATH="/home/vscode/.cargo/bin:$PATH"
    echo 'export PATH="/home/vscode/.cargo/bin:$PATH"' >> /home/vscode/.bashrc
    echo 'export PATH="/home/vscode/.cargo/bin:$PATH"' >> /home/vscode/.zshrc
    echo "✅ uv installed successfully"
else
    echo "✅ uv already installed"
fi

# Ensure uv is in PATH
export PATH="/home/vscode/.cargo/bin:$PATH"

# Verify Python version
echo "🐍 Checking Python version..."
python3 --version
python3 -c "import sys; print(f'Python {sys.version_info.major}.{sys.version_info.minor}.{sys.version_info.micro}')"

# Install Spec-Kit CLI using uv
echo "🌱 Installing Spec-Kit CLI..."
if ! command -v specify &> /dev/null; then
    echo "Installing specify-cli from GitHub..."
    /home/vscode/.cargo/bin/uv tool install specify-cli --from git+https://github.com/github/spec-kit.git
    echo "✅ Spec-Kit CLI installed successfully"
else
    echo "✅ Spec-Kit CLI already installed"
fi

# Add uv tools to PATH
echo 'export PATH="/home/vscode/.local/bin:$PATH"' >> /home/vscode/.bashrc
echo 'export PATH="/home/vscode/.local/bin:$PATH"' >> /home/vscode/.zshrc
export PATH="/home/vscode/.local/bin:$PATH"

# Create cache and local directories with proper permissions
echo "📁 Setting up cache directories..."
mkdir -p /home/vscode/.cache /home/vscode/.local
sudo chown -R vscode:vscode /home/vscode/.cache /home/vscode/.local

# Install additional helpful Python packages
echo "🐍 Installing helpful Python packages..."
/home/vscode/.cargo/bin/uv tool install black
/home/vscode/.cargo/bin/uv tool install flake8
/home/vscode/.cargo/bin/uv tool install pytest

# Set up shell completions and aliases
echo "🐚 Setting up shell enhancements..."
cat >> /home/vscode/.bashrc << 'EOF'

# Spec-Kit aliases and shortcuts
alias spec='specify'
alias spec-init='specify init'
alias spec-check='specify check'

# Helpful development aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias py='python3'
alias pip='uv pip'

# Environment info
echo "🌱 Spec-Kit Development Environment Ready!"
echo "Available commands:"
echo "  - specify: Spec-Kit CLI"
echo "  - spec: Short alias for specify"
echo "  - uv: Python package manager"
echo "  - python3: Python interpreter"
echo ""
echo "Run 'specify check' to verify your setup!"
EOF

# Verify installation
echo ""
echo "🔍 Verifying installation..."
echo "Python version: $(python3 --version)"
echo "uv version: $(/home/vscode/.cargo/bin/uv --version || echo 'uv not found in PATH')"
echo "Git version: $(git --version)"

# Try to verify specify installation
if command -v /home/vscode/.local/bin/specify &> /dev/null; then
    echo "Spec-Kit CLI version: $(/home/vscode/.local/bin/specify --version || echo 'Version command not available')"
    echo "✅ Spec-Kit CLI is available at /home/vscode/.local/bin/specify"
else
    echo "⚠️  Spec-Kit CLI may need manual PATH configuration"
fi

echo ""
echo "🎉 Setup complete! Please reload your shell or restart the container."
echo "   Run 'specify check' to verify all tools are working correctly."
echo ""