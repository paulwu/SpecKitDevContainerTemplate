# Template Validation System

This repository uses automated validation to ensure contributions only modify template infrastructure files, keeping the repository clean and focused as a template.

## 🤖 Automated Checks

Every pull request automatically runs validation that checks:

- ✅ **File restrictions** - Only template files can be modified
- ✅ **DevContainer config** - JSON syntax and structure validation  
- ✅ **Security scanning** - Detect potential exposed secrets
- ✅ **Documentation structure** - Required sections present

## 📁 Allowed File Patterns

The validation allows changes to these files and directories:

```
✅ .devcontainer/          DevContainer configuration
✅ .github/                GitHub workflows & issue templates  
✅ README.md              Main documentation
✅ SETUP.md               Setup instructions
✅ CONTRIBUTING.md        Contribution guidelines
✅ example-init.sh        Template scripts
✅ validate-template.sh   Validation script
✅ .gitignore             Git configuration
✅ .gitattributes         Git attributes
```

❌ **Blocked:** Any user project files or application code

## 🧪 Local Testing

Test your changes locally before submitting a PR:

```bash
# Make the script executable (first time only)
chmod +x validate-template.sh

# Run validation
./validate-template.sh
```

This runs the same checks that will run automatically on your PR.

## 🚨 Common Validation Failures

### "Not a template file" Error
```
❌ src/index.html - Not a template file
❌ app/server.js - Not a template file
```
**Fix:** Don't add your project files. Use this repository as a template instead.

### "DevContainer JSON syntax error"
```
❌ devcontainer.json has syntax errors
```
**Fix:** Check JSON syntax in `.devcontainer/devcontainer.json`

### "Potential security issues"
```
⚠️ config.js: contains 'api_key'
```
**Fix:** Use placeholder values like `YOUR_API_KEY_HERE` instead of real secrets

## 🔧 How It Works

1. **PR Created** → GitHub Actions triggers validation workflow
2. **File Analysis** → Compares changed files against allowed patterns  
3. **Security Scan** → Checks for exposed secrets or tokens
4. **Config Tests** → Validates DevContainer and documentation structure
5. **Pass/Fail** → Shows detailed results and guidance

## 📋 Example Validation Output

### ✅ Successful Validation
```
✅ PR VALIDATION PASSED
All changes are to template files only. Thank you for contributing!
```

### ❌ Failed Validation  
```
❌ PR VALIDATION FAILED

The following files are not allowed:
  - src/server.js
  - app/package.json
  - public/index.html

💡 To create your own SpecKit project:
   1. Use this repository as a template (not fork)
   2. Click 'Use this template' button on GitHub
```

## 🤝 Getting Help

- **Template issues:** Create issue with our templates
- **Validation questions:** Comment on your PR
- **SpecKit help:** Visit [SpecKit repository](https://github.com/github/spec-kit)

## 💡 Pro Tips

1. **Fork vs Template:** Use "Use this template" button, don't fork for your projects
2. **Small PRs:** Focus on one improvement per PR
3. **Test locally:** Run `./validate-template.sh` before pushing
4. **Clear descriptions:** Explain what template improvement you made
5. **Pure template:** This is infrastructure only - no application code

---

This validation system helps maintain the repository as a clean, reusable template for the SpecKit community! 🌟