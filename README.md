# SpecKitTest

A development environment setup for working with [GitHub Spec-Kit](https://github.com/github/spec-kit), a comprehensive toolkit for Spec-Driven Development (SDD).

## 🚀 Quick Start with DevContainer

This repository includes a complete DevContainer configuration that provides all the tools needed to work with Spec-Kit.

### Prerequisites
- [VS Code](https://code.visualstudio.com/) with the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) or compatible container runtime

### Getting Started

1. **Clone and Open**
   ```bash
   git clone https://github.com/paulwu/SpecKitTest.git
   cd SpecKitTest
   code .
   ```

2. **Open in DevContainer**
   - When prompted, click "Reopen in Container"
   - Or use Command Palette: `Dev Containers: Reopen in Container`

3. **Initialize Your First Project**
   ```bash
   # Create a new Spec-Kit project
   specify init my-project --ai copilot
   
   # Or initialize in current directory
   specify init --here --ai copilot
   ```

4. **Verify Setup**
   ```bash
   specify check
   ```

## 🛠️ What's Included

### Core Tools
- **Python 3.11+** - Required runtime for Spec-Kit
- **uv Package Manager** - Modern Python package management
- **Specify CLI** - Pre-installed from GitHub repository
- **Git & GitHub CLI** - Version control and GitHub integration
- **Node.js & npm** - For JavaScript-based AI tools

### AI Coding Agents
- ✅ **GitHub Copilot** - Pre-configured in VS Code
- ⚠️ **Claude Code CLI** - Available (requires API key setup)
- ⚠️ **Gemini CLI** - Available via npm (requires API key)
- ⚠️ **opencode CLI** - Available via npm
- ⚠️ **Cursor, Qwen, Windsurf** - May require additional setup

### VS Code Extensions
- GitHub Copilot & Copilot Chat
- Python development tools (linting, formatting)
- Git integration (GitLens)
- Markdown and YAML support
- Spell checking and more

## 📚 Learn More

- **[Spec-Kit Documentation](https://github.com/github/spec-kit)** - Complete guide to Spec-Driven Development
- **[DevContainer README](.devcontainer/README.md)** - Detailed DevContainer setup and customization
- **[Spec-Driven Development Methodology](https://github.com/github/spec-kit/blob/main/spec-driven.md)** - Deep dive into the SDD process

## 🎯 What is Spec-Driven Development?

Spec-Driven Development flips the traditional approach to software development:
- **Specifications become executable** - directly generating working implementations
- **Intent-driven development** - define the "what" before the "how"  
- **Multi-step refinement** - structured process rather than one-shot generation
- **AI-powered** - leverages advanced AI models for specification interpretation

## 🔧 Manual Setup (Alternative)

If you prefer not to use DevContainer:

1. **Install Prerequisites**
   - Python 3.11+
   - uv package manager: `curl -LsSf https://astral.sh/uv/install.sh | sh`
   - Git

2. **Install Spec-Kit CLI**
   ```bash
   uv tool install specify-cli --from git+https://github.com/github/spec-kit.git
   ```

3. **Install AI Coding Agents** (optional)
   - Follow respective installation guides for Claude, Gemini, etc.

## 🤝 Contributing

This repository serves as a template and testing ground for Spec-Kit integration. Feel free to:
- Report issues with the DevContainer setup
- Suggest improvements to the development environment
- Share examples of successful Spec-Kit projects

## 📄 License

This project is provided as-is for educational and development purposes. See the [GitHub Spec-Kit repository](https://github.com/github/spec-kit) for license information.