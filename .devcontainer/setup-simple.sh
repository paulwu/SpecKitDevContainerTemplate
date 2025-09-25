#!/bin/bas#!/bin/bash
set -e

echo "🌱 Setting up Simple Spec-Kit Development Environment"
echo "=================================================="

# Update system packages
echo "📦 Updating system packages..."
sudo apt-get update -y

# Install essential tools
echo "🔧 Installing essential tools..."
sudo apt-get install -y \
    curl \
    wget \
    git \
    build-essential \
    ca-certificates
echo "🌱 Setting up Simple Spec-Kit Development Environment"
echo "=================================================="

# Update system packages
echo "📦 Updating system packages..."
apt-get update -y

# Install Python 3.11 and essential tools
echo "� Installing Python 3.11 and essential tools..."
apt-get install -y \
    software-properties-common \
    curl \
    wget \
    git \
    build-essential \
    ca-certificates

# Add deadsnakes PPA for Python 3.11
add-apt-repository ppa:deadsnakes/ppa -y
apt-get update -y

# Install Python 3.11
apt-get install -y \
    python3.11 \
    python3.11-dev \
    python3.11-venv \
    python3-pip

# Create symlinks for python and python3
ln -sf /usr/bin/python3.11 /usr/local/bin/python
ln -sf /usr/bin/python3.11 /usr/local/bin/python3

# Install uv package manager
echo "📦 Installing uv package manager..."
if ! command -v uv &> /dev/null; then
    curl -LsSf https://astral.sh/uv/install.sh | sh
    export PATH="/home/vscode/.cargo/bin:$PATH"
    echo 'export PATH="/home/vscode/.cargo/bin:$PATH"' >> /home/vscode/.bashrc
    echo "✅ uv installed successfully"
else
    echo "✅ uv already installed"
fi

# Ensure uv is in PATH
export PATH="/home/vscode/.cargo/bin:$PATH"

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
export PATH="/home/vscode/.local/bin:$PATH"

# Set up aliases
echo "🐚 Setting up aliases..."
cat >> /home/vscode/.bashrc << 'EOF'

# Spec-Kit aliases
alias spec='specify'
alias spec-init='specify init'
alias spec-check='specify check'

echo "🌱 Simple Spec-Kit Environment Ready!"
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
    echo "✅ Spec-Kit CLI is available"
else
    echo "⚠️  Spec-Kit CLI may need manual PATH configuration"
fi

echo ""
echo "🎉 Simple setup complete!"
echo "   Run 'source ~/.bashrc' then 'specify check' to verify."
echo ""