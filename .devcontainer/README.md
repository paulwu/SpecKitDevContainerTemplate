# Spec-Kit DevContainer

This DevContainer provides a complete development environment for working with [GitHub Spec-Kit](https://github.com/github/spec-kit), a toolkit for Spec-Driven Development (SDD).

## What's Included

### Core Tools
- **Python 3.11+** - Required for Spec-Kit CLI
- **uv Package Manager** - Modern Python package management
- **Git** - Version control with sensible defaults
- **GitHub CLI** - For GitHub integration
- **Node.js & npm** - For JavaScript-based AI tools

### Spec-Kit Integration
- **Specify CLI** - Pre-installed from the official GitHub repository
- **VS Code Extensions** - GitHub Copilot, Python tools, and productivity extensions
- **AI Agent Support** - Prepared for multiple AI coding assistants

### AI Coding Agents Supported
- ✅ **GitHub Copilot** - Built into VS Code (requires subscription)
- ⚠️ **Claude Code CLI** - May require manual setup and API key
- ⚠️ **Gemini CLI** - Available via npm, requires API key
- ⚠️ **opencode CLI** - Available via npm
- ⚠️ **Cursor** - Requires separate IDE download
- ⚠️ **Qwen Code** - May require manual installation
- ⚠️ **Windsurf** - Requires separate IDE download

## Getting Started

### Prerequisites
- **VS Code** with the Remote-Containers extension
- **Docker Desktop** or compatible container runtime

### Quick Start

1. **Open in DevContainer**
   ```bash
   # Clone this repository
   git clone https://github.com/paulwu/SpecKitTest.git
   cd SpecKitTest
   
   # Open in VS Code
   code .
   
   # When prompted, click "Reopen in Container"
   # Or use Command Palette: "Dev Containers: Reopen in Container"
   ```

2. **Initialize a Spec-Kit Project**
   ```bash
   # Create a new project
   specify init my-project --ai copilot
   
   # Or initialize in current directory
   specify init --here --ai copilot
   ```

3. **Check System Requirements**
   ```bash
   specify check
   ```

### Configuration

#### Git Setup
Configure Git with your credentials:
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

#### AI Agent Setup
- **GitHub Copilot**: Already configured in VS Code
- **Claude Code**: Follow [Claude Code setup instructions](https://docs.anthropic.com/claude/docs/claude-code)
- **Gemini CLI**: Install and configure with your API key
- **Other agents**: Refer to their respective documentation

## Available Commands

### Spec-Kit Commands
- `specify init <project>` - Initialize new project
- `specify check` - Check tool requirements
- `specify init --here` - Initialize in current directory

### Development Commands
- `uv tool list` - List installed Python tools
- `uv tool upgrade specify-cli` - Update Spec-Kit CLI
- `gh auth login` - Authenticate with GitHub

## Directory Structure

After initialization, your project will have:
```
├── .devcontainer/          # DevContainer configuration
├── memory/                 # Project constitution and memory
├── scripts/               # Automation scripts
├── specs/                 # Feature specifications
├── templates/             # Project templates
└── [your-code]/          # Implementation files
```

## Troubleshooting

### Common Issues

**Specify CLI not found**
```bash
# Reinstall the CLI
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git
```

**AI agent not working**
- Check if the agent CLI is installed: `which claude` / `which gemini`
- Verify API keys are configured
- Run `specify check` to diagnose issues

**Permission issues**
```bash
# Fix file permissions
sudo chown -R vscode:vscode /workspaces
```

### Getting Help

- **Spec-Kit Documentation**: https://github.com/github/spec-kit
- **DevContainer Documentation**: https://code.visualstudio.com/docs/devcontainers/containers
- **Issue Tracker**: https://github.com/github/spec-kit/issues

## Customization

### Adding Extensions
Edit `.devcontainer/devcontainer.json` to add VS Code extensions:
```json
"extensions": [
    "your.extension.id"
]
```

### Installing Additional Tools
Modify `.devcontainer/Dockerfile` or `.devcontainer/post-create.sh` to add tools.

### Environment Variables
Set environment variables in `devcontainer.json`:
```json
"containerEnv": {
    "YOUR_VAR": "value"
}
```

## License

This DevContainer configuration is provided as-is for use with GitHub Spec-Kit. See the main repository for license information.