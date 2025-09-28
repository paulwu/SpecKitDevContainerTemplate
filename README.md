# SpecKitDevContainerBase


This repository provides a GitHub template with a DevContainer for setting up a development environment tailored for the [Spec-Kit framework](https://github.com/github/spec-kit) to enable GitHub Copilot-assisted development. It includes all necessary tools, dependencies, and configurations to kickstart your project, ensuring a consistent and reproducible setup.

Since this repository is a template, you should always create a new repository from this template to work in. Although this repository contains no application code, it provides a preconfigured development container (DevContainer) that automates the installation of tools and dependencies. Your repository will serve as a scaffold for Spec-Kit projects, optimized for GitHub Copilot integration.



## 🌱 About Spec-Kit


Spec-Kit enables **Spec-Driven Development** — a methodology that flips traditional development by making specifications executable and directly generating working implementations. Instead of writing code first and documentation later, you define what you want to build (the spec) and let AI agents implement it according to your technical plans.


## 📋 Prerequisites

This project requires **WSL2** (Windows Subsystem for Linux) installed on your Windows computer and **Docker** installed in WSL. If you already have these prerequisites, proceed to the [QuickStart - Step 1](#1-clone-and-open-in-wsl).


### Required Components

- **WSL2** with Ubuntu distribution

- **Docker Engine** installed in WSL (not Docker Desktop)

- **VS Code** with Dev Containers extension



### 📚 First Time Setup

**New to WSL/Docker?** See our [Complete Setup Guide](./SETUP.md) for detailed step-by-step instructions.


### ⚠️ Important Notes

- **Always open this project from within WSL** (not from Windows file system)

- Project must be located in WSL filesystem (`/home/username/...`)

- Docker must be running in WSL before opening DevContainer

- Use `code .` from WSL terminal, not Windows file explorer


## 🚀 Quick Start

### 1. Create your repo from the template

1. Navigate to the [SpecKitDevContainerTemplate](https://github.com/paulwu/SpecKitDevContainerTemplate) repo on GitHub.
2. Click the green “Use this template” button
3. Select “Create a new repository” and fill in the details (e.g., repository name, visibility like public/private).
4. This creates a new repository (e.g., https://github.com/your-username/new-project) based on the template, with a clean commit history (no history from the template repo).
5. Get the URL for the repo. You'll need this URL in the next step. It should look like https://github.com/your-username/new-project.git

### 2. Clone and Open in WSL

```bash

# From your WSL terminal# From your WSL terminal

# 1. Ensure Docker is running
sudo service docker start

# 2. Clone and open project
git clone <https://github.com/your-username/new-project.git>

cd <new-project>

code .  # Opens VS Code in WSL mode

# 3. Reopen in Container when prompted
```


### 3. Open in DevContainer

This repository is configured with a DevContainer that includes all necessary tools for Spec-Kit development:


- **Python 3.11+** - Required runtime

- **uv** - Modern Python package manager

- **Git + Git Credential Manager** - Version control with authentication

- **Spec-Kit CLI** - The core tool for spec-driven development

- **GitHub Copilot** - AI coding assistant integration

- **Development utilities** - curl, wget, build tools, etc.


**To get started:**

1. Ensure Docker is running in WSL: `sudo service docker start`

2. Open this repository in VS Code **from WSL**

3. When prompted, click "Reopen in Container"

4. Wait for the container to build and setup to complete

5. Open a terminal and run: `specify check`


### 3. Initialize Your First Project

Once the DevContainer is running, you can initialize a new Spec-Kit project:


```bash

# Initialize a new project with GitHub Copilot
specify init my-project --ai copilot


# Or initialize in the current directory
specify init --here --ai copilot

```



### 4. Available AI Agents

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
/constitution Create principles focused on code quality, testing standards, user experience consistency, and performance requirements


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

1. **Docker not found / DevContainer won't start**

```bash

   # Ensure Docker is running in WSL   
   sudo service docker start   

   # Check Docker status
   sudo service docker status
   
   # Verify Docker works  
   docker run hello-world
   
   ```



2. **Permission denied when accessing Docker**

```bash

   # Add user to docker group (then restart WSL) 
   sudo usermod -aG docker $USER   


   # Restart WSL session  
   exit  # then reopen WSL terminal
   
```



3. **DevContainer build fails**

```bash

   # Clean Docker cache (run from WSL)   
   docker system prune -a
        
   # Rebuild container in VS Code
   
   # Ctrl+Shift+P → "Dev Containers: Rebuild Container"

 ```



4. **VS Code can't find WSL/files**

   - **Always open project from WSL terminal** using `code .`
   
   - Don't open from Windows file explorer
   
   - Project must be in WSL file system (`/home/username/...`)
   

5. **Spec-Kit CLI not found**
   ```bash

   # Ensure PATH includes uv tools
   export PATH="/home/vscode/.local/bin:$PATH"
   
   source ~/.bashrc
   
   ```



6. **Git authentication issues**

   ```bash
   
   # Git Credential Manager should be configured automatically
   
   git config --global credential.helper manager
   
   ```



### Getting Help

- Run `specify check` to verify your setup

- Check the [Spec-Kit documentation](https://github.com/github/spec-kit)

- Open issues at [github.com/github/spec-kit/issues](https://github.com/github/spec-kit/issues)

## 📚 Learn More

- [Complete Setup Guide](./SETUP.md) - Detailed installation instructions

- [Complete Spec-Driven Development Methodology](https://github.com/github/spec-kit/blob/main/spec-driven.md)

- [Spec-Kit Video Overview](https://www.youtube.com/watch?v=a9eR1xsfvHg)

- [GitHub Spec-Kit Repository](https://github.com/github/spec-kit)

## 📄 License

This project template is provided under the MIT License. Spec-Kit itself is also MIT licensed.
