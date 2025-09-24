#!/bin/bash
set -e

echo "🌱 Setting up Simple Spec-Kit Development Environment"
echo "=================================================="

# Update system packages
echo "📦 Updating system packages..."
apt-get update -y

# Install essential tools
echo "🔧 Installing essential tools..."
apt-get install -y \
    curl \
    wget \
    git \
    build-essential \
    ca-certificates

# Install uv package manager
echo "📦 Installing uv package manager..."
if ! command -v uv &> /dev/null; then
    curl -LsSf https://astral.sh/uv/install.sh | sh
    export PATH="/root/.cargo/bin:$PATH"
    echo 'export PATH="/root/.cargo/bin:$PATH"' >> /root/.bashrc
    echo "✅ uv installed successfully"
else
    echo "✅ uv already installed"
fi

# Ensure uv is in PATH
export PATH="/root/.cargo/bin:$PATH"

# Install Spec-Kit CLI using uv
echo "🌱 Installing Spec-Kit CLI..."
if ! command -v specify &> /dev/null; then
    echo "Installing specify-cli from GitHub..."
    /root/.cargo/bin/uv tool install specify-cli --from git+https://github.com/github/spec-kit.git
    echo "✅ Spec-Kit CLI installed successfully"
else
    echo "✅ Spec-Kit CLI already installed"
fi

# Add uv tools to PATH
echo 'export PATH="/root/.local/bin:$PATH"' >> /root/.bashrc
export PATH="/root/.local/bin:$PATH"

# Set up aliases
echo "🐚 Setting up aliases..."
cat >> /root/.bashrc << 'EOF'

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
echo "uv version: $(/root/.cargo/bin/uv --version || echo 'uv not found in PATH')"
echo "Git version: $(git --version)"

# Try to verify specify installation
if command -v /root/.local/bin/specify &> /dev/null; then
    echo "Spec-Kit CLI version: $(/root/.local/bin/specify --version || echo 'Version command not available')"
    echo "✅ Spec-Kit CLI is available"
else
    echo "⚠️  Spec-Kit CLI may need manual PATH configuration"
fi

echo ""
echo "🎉 Simple setup complete!"
echo "   Run 'source ~/.bashrc' then 'specify check' to verify."
echo ""