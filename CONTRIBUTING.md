# Contributing to SpecKitDevContainerBase

Thank you for your interest in improving the SpecKit DevContainer template! This repository serves as a **template foundation** for SpecKit projects, not a place for individual project development.

## 🎯 What We Accept

✅ **Template Infrastructure Changes:**
- `.devcontainer/` configuration updates and improvements
- `README.md`, `SETUP.md`, and documentation enhancements  
- `example-init.sh` and setup script optimizations
- GitHub workflows and issue templates (`.github/`)
- Validation scripts (`validate-template.sh`)
- Bug fixes and performance improvements

❌ **What We Don't Accept:**
- User project code or application files
- Personal configuration files or environment-specific settings
- Application-specific dependencies or tools
- Project-specific implementations or business logic
- Files that would make this template less reusable

## 🚀 How to Contribute

### For Template Improvements:

1. **Fork this repository**
2. **Make changes only to template files** (see allowed files below)
3. **Test your changes** - ensure DevContainer still builds and works
4. **Submit a pull request** with clear description of improvements
5. **Automated validation** - our GitHub Actions will check your changes

### For Your Own Projects:

1. **Use this as a template** - click "Use this template" button on GitHub
2. **Create your own repository** - develop your project there
3. **Don't submit project code here** - this keeps the template clean

## 🛡️ Automated Validation

All pull requests are automatically validated by GitHub Actions to ensure:

- ✅ Only template files are modified
- ✅ DevContainer configuration is valid
- ✅ No security issues (exposed tokens, etc.)
- ✅ Documentation structure is maintained

**The validation will fail if you:**
- Add user project files outside allowed template areas
- Modify files that would break template reusability
- Include personal or project-specific configurations

## 📁 Allowed File Patterns

Our automated validation allows changes to these areas:

```
├── .devcontainer/          ✅ DevContainer configuration
├── .github/                ✅ GitHub workflows & issue templates
├── README.md              ✅ Main documentation  
├── SETUP.md               ✅ Setup instructions
├── CONTRIBUTING.md        ✅ This file
├── example-init.sh        ✅ Template scripts
├── validate-template.sh   ✅ Validation script
├── .gitignore             ✅ Git configuration
└── .gitattributes         ✅ Git configuration
```

## 🧪 Testing Your Changes

Before submitting a PR, please:

1. **Test DevContainer builds:** Ensure `.devcontainer/devcontainer.json` is valid
2. **Verify setup scripts:** Check that `example-init.sh` and `.devcontainer/setup-simple.sh` work
3. **Validate documentation:** Ensure README.md and SETUP.md are accurate
4. **Run local validation:** Execute `./validate-template.sh` to check your changes

## 📝 Pull Request Guidelines

**Good PR titles:**
- `feat: Add Python linting tools to DevContainer`
- `docs: Update WSL setup instructions for Windows 11`
- `fix: Correct SpecKit CLI installation in setup script`

**Include in your PR description:**
- What template improvement you made
- Why it benefits template users
- How you tested the changes
- Any breaking changes or migration needed

## 🤝 Getting Help

- **Template bugs:** Use our issue templates to report problems
- **Feature requests:** Suggest template improvements via issues
- **SpecKit questions:** Visit the [main SpecKit repository](https://github.com/github/spec-kit)
- **General discussions:** Use [SpecKit Discussions](https://github.com/github/spec-kit/discussions)

## ⚡ Quick Reference

| I want to... | Action |
|--------------|--------|
| Report a template bug | [Create bug report issue](https://github.com/paulwu/SpecKitDevContainerTemplate/issues/new?template=bug-report.yml) |
| Suggest template improvement | [Create improvement issue](https://github.com/paulwu/SpecKitDevContainerTemplate/issues/new?template=template-improvement.yml) |
| Build my own project | [Use this template](https://github.com/paulwu/SpecKitDevContainerTemplate/generate) |
| Ask SpecKit questions | [SpecKit Discussions](https://github.com/github/spec-kit/discussions) |

---

**Remember:** This repository is a template foundation. Keep it clean and reusable for everyone! 🌟