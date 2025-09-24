# Spec-Kit Examples

This document provides examples of how to use the Spec-Kit DevContainer environment for different types of projects.

## 🚀 Quick Start Examples

### Example 1: Web Application Project

```bash
# Initialize a new web application project
specify init photo-organizer --ai copilot

# Change to the project directory
cd photo-organizer

# Start the Spec-Driven Development process
# 1. Create project constitution
/constitution Create principles focused on user experience, performance, and maintainability. Emphasize responsive design, accessibility, and clean code practices.

# 2. Define what you want to build
/specify Build a photo organizer web application that allows users to create albums, upload photos, and organize them by drag-and-drop. The interface should be clean and intuitive with thumbnail previews.

# 3. Create implementation plan
/plan Use vanilla HTML, CSS, and JavaScript with minimal dependencies. Store metadata in local SQLite database. No user authentication required for this MVP.

# 4. Generate tasks
/tasks

# 5. Implement the feature
/implement
```

### Example 2: API Service Project

```bash
# Initialize an API project
specify init task-api --ai copilot

cd task-api

# Constitution for API development
/constitution Focus on API design best practices, comprehensive error handling, proper HTTP status codes, and thorough documentation. Prioritize security and scalability.

# Specify the API requirements
/specify Create a REST API for task management with endpoints for creating, reading, updating, and deleting tasks. Include filtering, sorting, and pagination. Tasks should have title, description, status, priority, and due date.

# Technical implementation plan
/plan Build with Python FastAPI framework, use PostgreSQL database with SQLAlchemy ORM, include Pydantic models for validation, and OpenAPI documentation generation.

# Generate and implement
/tasks
/implement
```

### Example 3: Desktop Application

```bash
# Initialize desktop app project
specify init expense-tracker --ai claude

cd expense-tracker

/constitution Emphasize cross-platform compatibility, intuitive UI/UX, data privacy, and offline capability. Follow platform-specific design guidelines.

/specify Build a personal expense tracking desktop application. Users can add expenses with categories, dates, amounts, and notes. Include monthly/yearly reports with charts and export capabilities.

/plan Use Python with Tkinter for the GUI, SQLite for local data storage, matplotlib for charts, and cx_Freeze for distribution packaging.

/tasks
/implement
```

## 🔧 Working with Different AI Agents

### GitHub Copilot (Pre-configured)
```bash
# Copilot is ready to use in VS Code
specify init my-project --ai copilot
# Use slash commands directly in the terminal or VS Code
```

### Claude Code CLI
```bash
# First, authenticate Claude (requires API key)
claude auth login

# Initialize with Claude
specify init my-project --ai claude

# Use Claude commands
claude /constitution
claude /specify
# etc.
```

### Gemini CLI
```bash
# Install and configure Gemini CLI
npm install -g @google-ai/generativelanguage
gemini config set api-key YOUR_API_KEY

# Initialize with Gemini
specify init my-project --ai gemini

# Use Gemini commands
gemini /constitution
gemini /specify
# etc.
```

## 📁 Expected Project Structure

After running `specify init`, your project will have this structure:

```
my-project/
├── .devcontainer/          # DevContainer configuration (if initialized with --here)
├── .github/
│   └── prompts/           # GitHub Copilot prompts (if using copilot)
├── .claude/               # Claude Code commands (if using claude)
│   └── commands/
├── memory/
│   └── constitution.md    # Project principles
├── scripts/
│   ├── check-prerequisites.sh
│   ├── common.sh
│   ├── create-new-feature.sh
│   ├── setup-plan.sh
│   └── update-agent-context.sh
├── specs/
│   └── 001-feature-name/  # Feature specifications
│       ├── spec.md
│       ├── plan.md
│       ├── tasks.md
│       └── contracts/
├── templates/
│   ├── spec-template.md
│   ├── plan-template.md
│   └── tasks-template.md
└── [implementation-files] # Your actual code
```

## 🎯 Development Workflow

### 1. Constitution Phase
Define your project's guiding principles:
- Code quality standards
- User experience requirements
- Performance criteria
- Security considerations
- Testing approach

### 2. Specification Phase
Create detailed functional requirements:
- User stories
- Acceptance criteria
- Business rules
- Integration requirements

### 3. Planning Phase
Technical implementation details:
- Architecture decisions
- Technology stack
- Database design
- API specifications
- Deployment strategy

### 4. Task Breakdown
Actionable development tasks:
- Implementation order
- Dependencies
- Testing requirements
- Documentation needs

### 5. Implementation
Execute the plan:
- Follow TDD approach
- Implement features incrementally
- Run tests continuously
- Update documentation

## 🛠️ Troubleshooting Common Issues

### AI Agent Not Working
```bash
# Check if agent is properly installed
specify check

# Re-authenticate if needed
claude auth login    # for Claude
gemini config set api-key YOUR_KEY  # for Gemini
```

### Permission Issues
```bash
# Fix file permissions
sudo chown -R vscode:vscode /workspaces
chmod +x scripts/*.sh
```

### Missing Dependencies
```bash
# Reinstall Spec-Kit CLI
uv tool uninstall specify-cli
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git

# Update tools
uv tool upgrade specify-cli
```

## 📚 Additional Resources

- [Spec-Kit Official Documentation](https://github.com/github/spec-kit)
- [Spec-Driven Development Guide](https://github.com/github/spec-kit/blob/main/spec-driven.md)
- [AI Agent Setup Guides](https://github.com/github/spec-kit/blob/main/AGENTS.md)

## 💡 Tips for Success

1. **Start with a clear constitution** - It guides all subsequent decisions
2. **Be specific in specifications** - Avoid ambiguous requirements
3. **Choose appropriate tech stacks** - Match tools to project needs
4. **Iterate and refine** - Use the clarification phase effectively
5. **Test frequently** - Validate each phase before moving forward
6. **Document as you go** - Keep specifications up to date

## 🤝 Contributing Examples

Have a successful Spec-Kit project? Share your example:
1. Create a new branch
2. Add your example to this file
3. Include the project structure and key commands used
4. Submit a pull request