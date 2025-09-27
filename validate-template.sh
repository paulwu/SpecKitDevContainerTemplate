#!/bin/bash

# Local validation script for SpecKit DevContainer template
# Run this before submitting PRs to check your changes

echo "🔍 SpecKit Template Validation"
echo "=============================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if we're in a git repository
if ! git status &> /dev/null; then
    echo -e "${RED}❌ Not in a git repository${NC}"
    exit 1
fi

# Get changed files compared to main branch
echo -e "${BLUE}📋 Checking changed files...${NC}"

# Try to get changes against origin/main, fallback to main, then just show all files
if git show-ref --verify --quiet refs/remotes/origin/main; then
    CHANGED_FILES=$(git diff --name-only origin/main...HEAD 2>/dev/null)
    COMPARE_BRANCH="origin/main"
elif git show-ref --verify --quiet refs/heads/main; then
    CHANGED_FILES=$(git diff --name-only main...HEAD 2>/dev/null)
    COMPARE_BRANCH="main"
else
    echo -e "${YELLOW}⚠️  No main branch found, showing all tracked files${NC}"
    CHANGED_FILES=$(git ls-files)
    COMPARE_BRANCH="all files"
fi

if [ -z "$CHANGED_FILES" ]; then
    echo -e "${GREEN}✅ No changes detected${NC}"
    exit 0
fi

echo -e "${BLUE}Comparing against: $COMPARE_BRANCH${NC}"
echo

# Define allowed patterns for template files
ALLOWED_PATTERNS=(
    "^\.devcontainer/"
    "^\.github/"
    "^README\.md$"
    "^SETUP\.md$"
    "^CONTRIBUTING\.md$"
    "^example-init\.sh$"
    "^validate-template\.sh$"
    "^\.gitignore$"
    "^\.gitattributes$"
    "^LICENSE$"
)

# Validate each changed file
INVALID_FILES=""
VALID_COUNT=0
INVALID_COUNT=0

while IFS= read -r file; do
    if [[ -n "$file" ]]; then
        ALLOWED=false
        for pattern in "${ALLOWED_PATTERNS[@]}"; do
            if [[ "$file" =~ $pattern ]]; then
                ALLOWED=true
                echo -e "${GREEN}✅ $file${NC} - Template file"
                ((VALID_COUNT++))
                break
            fi
        done
        
        if [[ "$ALLOWED" == false ]]; then
            INVALID_FILES="$INVALID_FILES\n  ${RED}❌ $file${NC}"
            echo -e "${RED}❌ $file${NC} - Not a template file"
            ((INVALID_COUNT++))
        fi
    fi
done <<< "$CHANGED_FILES"

echo
echo -e "${BLUE}📊 Summary:${NC}"
echo -e "  Valid template files: ${GREEN}$VALID_COUNT${NC}"
echo -e "  Invalid files: ${RED}$INVALID_COUNT${NC}"

# Show results
if [[ $INVALID_COUNT -gt 0 ]]; then
    echo
    echo -e "${RED}❌ VALIDATION FAILED${NC}"
    echo
    echo -e "${YELLOW}The following files are not allowed in template PRs:${NC}"
    echo -e "$INVALID_FILES"
    echo
    echo -e "${BLUE}📋 Allowed file patterns:${NC}"
    echo "  • .devcontainer/ - DevContainer configuration"
    echo "  • .github/ - GitHub workflows and templates"
    echo "  • README.md, SETUP.md, CONTRIBUTING.md - Documentation"
    echo "  • example-init.sh, validate-template.sh - Template scripts"
    echo "  • .gitignore, .gitattributes - Git configuration"
    echo
    echo -e "${YELLOW}💡 To create your own SpecKit project:${NC}"
    echo "   1. Use this repository as a template (not fork)"
    echo "   2. Click 'Use this template' button on GitHub"
    echo "   3. Develop your project in your own repository"
    echo "   4. Run 'specify init --here --ai copilot' to get started"
    echo
    exit 1
fi

# Additional validation checks
echo
echo -e "${BLUE}🧪 Running additional checks...${NC}"

# Check devcontainer.json syntax if it was modified
if echo "$CHANGED_FILES" | grep -q "devcontainer.json"; then
    echo -e "${BLUE}Validating devcontainer.json...${NC}"
    if command -v python3 &> /dev/null; then
        if python3 -m json.tool .devcontainer/devcontainer.json > /dev/null 2>&1; then
            echo -e "${GREEN}✅ devcontainer.json is valid JSON${NC}"
        else
            echo -e "${RED}❌ devcontainer.json has syntax errors${NC}"
            exit 1
        fi
    else
        echo -e "${YELLOW}⚠️  Python3 not found, skipping JSON validation${NC}"
    fi
fi

# Check for potential secrets
echo -e "${BLUE}Checking for potential secrets...${NC}"
SECRET_PATTERNS=("password" "token" "api_key" "secret" "private_key")
FOUND_SECRETS=""

while IFS= read -r file; do
    if [[ -n "$file" && -f "$file" ]]; then
        for pattern in "${SECRET_PATTERNS[@]}"; do
            if grep -i "$pattern" "$file" | grep -v "example" | grep -v "placeholder" | grep -v "YOUR_.*_HERE" | grep -v "# " > /dev/null 2>&1; then
                FOUND_SECRETS="$FOUND_SECRETS\n  - $file: contains '$pattern'"
            fi
        done
    fi
done <<< "$CHANGED_FILES"

if [[ -n "$FOUND_SECRETS" ]]; then
    echo -e "${YELLOW}⚠️  Potential security issues found:${NC}"
    echo -e "$FOUND_SECRETS"
    echo
    echo "Please review these files to ensure no actual secrets are exposed."
    echo "Use placeholder values like 'YOUR_TOKEN_HERE' instead."
else
    echo -e "${GREEN}✅ No obvious security issues detected${NC}"
fi

echo
echo -e "${GREEN}🎉 VALIDATION PASSED${NC}"
echo -e "${GREEN}All changes are to template files only. Ready for PR!${NC}"
echo
echo -e "${BLUE}Next steps:${NC}"
echo "1. Commit your changes: git add . && git commit -m 'your message'"
echo "2. Push to your fork: git push"
echo "3. Create a pull request on GitHub"
echo "4. Our automated validation will run the same checks"