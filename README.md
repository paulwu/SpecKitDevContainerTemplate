# SpecKitTest

A DevContainer environment configured for Spec-Driven Development using [GitHub's Spec-Kit](https://github.com/github/spec-kit).

## 🌱 About Spec-Kit

Spec-Kit enables **Spec-Driven Development** - a methodology that flips traditional development by making specifications executable and directly generating working implementations. Instead of writing code first and documentation later, you define what you want to build (the spec) and let AI agents implement it according to your technical plans.

## 🚀 Quick Start

### 1. Open in DevContainer

This repository is configured with a DevContainer that includes all necessary tools for Spec-Kit development:

- **Python 3.11+** - Required runtime
- **uv** - Modern Python package manager
- **Git + Git Credential Manager** - Version control with authentication
- **Spec-Kit CLI** - The core tool for spec-driven development
- **GitHub Copilot** - AI coding assistant integration
- **Development utilities** - curl, wget, build tools, etc.

**To get started:**

1. Open this repository in VS Code
2. When prompted, click "Reopen in Container"
3. Wait for the container to build and setup to complete
4. Open a terminal and run: `specify check`

### 2. Initialize Your First Project

Once the DevContainer is running, you can initialize a new Spec-Kit project:

```bash
# Initialize a new project with GitHub Copilot
specify init my-project --ai copilot

# Or initialize in the current directory
specify init --here --ai copilot
```

### 3. Available AI Agents

Spec-Kit supports multiple AI coding agents:

| Agent | Command Flag | Status |
|-------|-------------|---------|
| GitHub Copilot | `--ai copilot` | ✅ Fully supported |
| Claude Code | `--ai claude` | ✅ Fully supported |
| Cursor | `--ai cursor` | ✅ Fully supported |
| Windsurf | `--ai windsurf` | ✅ Fully supported |
| Gemini CLI | `--ai gemini` | ✅ Fully supported |
| Qwen Code | `--ai qwen` | ✅ Fully supported |
| opencode | `--ai opencode` | ✅ Fully supported |

## 🛠️ Spec-Driven Development Workflow

After initializing a project, you'll have access to these slash commands in your AI agent:

### Core Commands

| Command | Purpose |
|---------|---------|
| `/constitution` | Create project governing principles and development guidelines |
| `/specify` | Define what you want to build (requirements and user stories) |
| `/clarify` | Clarify underspecified areas (run before `/plan`) |
| `/plan` | Create technical implementation plans with your tech stack |
| `/tasks` | Generate actionable task lists for implementation |
| `/analyze` | Cross-artifact consistency & coverage analysis |
| `/implement` | Execute all tasks to build the feature |

### Example Workflow

```bash
# 1. Start with project principles
/constitution Create principles focused on code quality, testing standards, 
user experience consistency, and performance requirements

# 2. Define what you want to build
/specify Build a photo album organizer with drag-and-drop functionality

# 3. Create technical plan
/plan Use Vite with vanilla HTML, CSS, JavaScript and SQLite database

# 4. Break down into tasks
/tasks

# 5. Implement the solution
/implement
```

## 📁 DevContainer Configuration

The DevContainer includes:

### Base Image

- `mcr.microsoft.com/devcontainers/python:3.11-bullseye`

### Features

- Git with latest version
- GitHub CLI
- Node.js LTS

### VS Code Extensions

- Python development tools (Python, Pylint, Black, Flake8)
- GitHub Copilot and Copilot Chat
- JSON, YAML, and PowerShell support

### Port Forwarding

- `8000` - Python Development Server
- `3000` - Node.js Development Server  
- `5000` - Flask Development Server
- `8080` - General Development Server

## 🔧 Manual Setup (Alternative)

If you prefer not to use the DevContainer, you can set up Spec-Kit manually:

### Prerequisites

- Linux/macOS (or WSL2 on Windows)
- Python 3.11+
- Git
- AI coding agent (GitHub Copilot, Claude Code, etc.)

### Installation

```bash
# Install uv package manager
curl -LsSf https://astral.sh/uv/install.sh | sh

# Install Spec-Kit CLI
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git

# Verify installation
specify check
```

## 🚀 Advanced Usage

### Environment Variables

- `SPECIFY_FEATURE` - Override feature detection for non-Git repositories
- `GH_TOKEN` / `GITHUB_TOKEN` - GitHub token for API requests

### PowerShell Support

```bash
# Initialize with PowerShell scripts (Windows/cross-platform)
specify init my-project --ai copilot --script ps
```

### Corporate Environments

```bash
# Use GitHub token for API requests
specify init my-project --ai claude --github-token ghp_your_token_here

# Skip SSL/TLS verification (not recommended)
specify init my-project --ai copilot --skip-tls
```

## 🔍 Troubleshooting

### Common Issues

1. **Spec-Kit CLI not found**

   ```bash
   # Ensure PATH includes uv tools
   export PATH="/home/vscode/.local/bin:$PATH"
   source ~/.bashrc
   ```

2. **Git authentication issues**

   ```bash
   # Git Credential Manager should be configured automatically
   git config --global credential.helper manager
   ```

3. **Container build issues**
   - Rebuild the container: `Ctrl+Shift+P` → "Dev Containers: Rebuild Container"
   - Check `.devcontainer/TROUBLESHOOTING.md` for network/DNS issues
   - **WSL + Docker users**: Run cleanup from WSL terminal, not Windows
   - Clear Docker cache if needed

### Getting Help

- Run `specify check` to verify your setup
- Check the [Spec-Kit documentation](https://github.com/github/spec-kit)
- Open issues at [github.com/github/spec-kit/issues](https://github.com/github/spec-kit/issues)

## 📚 Learn More

- [Complete Spec-Driven Development Methodology](https://github.com/github/spec-kit/blob/main/spec-driven.md)
- [Spec-Kit Video Overview](https://www.youtube.com/watch?v=a9eR1xsfvHg)
- [GitHub Spec-Kit Repository](https://github.com/github/spec-kit)

## 📄 License

This project template is provided under the MIT License. Spec-Kit itself is also MIT licensed.