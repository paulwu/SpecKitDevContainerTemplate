#!/bin/bash

# Post-create script for Spec-Kit DevContainer
# This script runs after the container is created to set up the development environment

set -e

echo "🌱 Setting up Spec-Kit development environment..."

# Ensure uv is in PATH
export PATH="$HOME/.cargo/bin:$PATH"

# Update PATH in shell profiles
echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.bashrc
echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.zshrc 2>/dev/null || true

# Verify installations
echo "📋 Checking installed tools..."

# Check Python
if command -v python3 &> /dev/null; then
    echo "✅ Python $(python3 --version) installed"
else
    echo "❌ Python not found"
fi

# Check uv
if command -v uv &> /dev/null; then
    echo "✅ uv $(uv --version) installed"
else
    echo "❌ uv not found"
fi

# Check Git
if command -v git &> /dev/null; then
    echo "✅ Git $(git --version) installed"
else
    echo "❌ Git not found"
fi

# Check specify CLI
if command -v specify &> /dev/null; then
    echo "✅ Specify CLI installed"
    specify check || echo "⚠️  Some Specify dependencies may need configuration"
else
    echo "❌ Specify CLI not found - attempting reinstall..."
    uv tool install specify-cli --from git+https://github.com/github/spec-kit.git
fi

# Check GitHub CLI
if command -v gh &> /dev/null; then
    echo "✅ GitHub CLI $(gh --version | head -n1) installed" 
else
    echo "❌ GitHub CLI not found"
fi

# Check AI coding agents (optional)
echo "🤖 Checking AI coding agents..."

if command -v claude &> /dev/null; then
    echo "✅ Claude CLI available"
else
    echo "⚠️  Claude CLI not available - may need manual installation"
fi

if command -v gemini &> /dev/null; then
    echo "✅ Gemini CLI available"
else
    echo "⚠️  Gemini CLI not available - install with: npm install -g @google-ai/generativelanguage"
fi

if command -v opencode &> /dev/null; then
    echo "✅ opencode CLI available"
else
    echo "⚠️  opencode CLI not available - install with: npm install -g @opencode/cli"
fi

# Create helpful directories
mkdir -p ~/workspace
mkdir -p ~/.config

# Set up Git configuration prompt
echo "📝 Git Configuration:"
echo "   Current git user.name: $(git config --global user.name 2>/dev/null || echo 'Not set')"
echo "   Current git user.email: $(git config --global user.email 2>/dev/null || echo 'Not set')"
echo ""
echo "   To configure Git for your projects, run:"
echo "   git config --global user.name 'Your Name'"
echo "   git config --global user.email 'your.email@example.com'"

echo ""
echo "🎉 Spec-Kit DevContainer setup complete!"
echo ""
echo "🚀 Quick Start:"
echo "   1. Initialize a new Spec-Kit project: specify init my-project"
echo "   2. Or initialize in current directory: specify init --here"
echo "   3. Check system requirements: specify check"
echo ""
echo "📚 Available AI agents:"
echo "   - GitHub Copilot (built into VS Code)"
echo "   - Claude Code (claude command)"
echo "   - Gemini CLI (gemini command)"
echo "   - opencode CLI (opencode command)"
echo "   - Cursor, Qwen, Windsurf (may require separate setup)"
echo ""
echo "💡 Learn more: https://github.com/github/spec-kit"
echo ""