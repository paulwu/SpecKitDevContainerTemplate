#!/bin/bash

# Test script to validate DevContainer setup
# This simulates what would happen during container creation

set -e

echo "🧪 Testing DevContainer setup simulation..."

# Test 1: Check required tools exist in the environment
echo "1️⃣ Checking for required system tools..."

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

if command_exists python3; then
    echo "✅ Python3: $(python3 --version)"
else
    echo "❌ Python3 not found"
    exit 1
fi

if command_exists git; then
    echo "✅ Git: $(git --version | head -n1)"
else
    echo "❌ Git not found"
    exit 1
fi

if command_exists curl; then
    echo "✅ curl available"
else
    echo "❌ curl not found"
    exit 1
fi

# Test 2: Check if we can validate the JSON configuration
echo -e "\n2️⃣ Validating DevContainer configuration..."
if python3 -m json.tool .devcontainer/devcontainer.json > /dev/null 2>&1; then
    echo "✅ devcontainer.json is valid JSON"
else
    echo "❌ devcontainer.json has JSON syntax errors"
    exit 1
fi

# Test 3: Validate shell script syntax
echo -e "\n3️⃣ Validating shell scripts..."
if bash -n .devcontainer/post-create.sh; then
    echo "✅ post-create.sh has valid syntax"
else
    echo "❌ post-create.sh has syntax errors"
    exit 1
fi

# Test 4: Check if key directories and files exist
echo -e "\n4️⃣ Checking DevContainer structure..."
required_files=(
    ".devcontainer/devcontainer.json"
    ".devcontainer/Dockerfile"
    ".devcontainer/post-create.sh"
    ".devcontainer/README.md"
    ".gitignore"
    "README.md"
)

for file in "${required_files[@]}"; do
    if [[ -f "$file" ]]; then
        echo "✅ $file exists"
    else
        echo "❌ $file missing"
        exit 1
    fi
done

# Test 5: Validate Dockerfile has key components
echo -e "\n5️⃣ Validating Dockerfile contents..."
dockerfile=".devcontainer/Dockerfile"

required_in_dockerfile=(
    "FROM mcr.microsoft.com/devcontainers/base"
    "python3.11"
    "uv"
    "curl -LsSf https://astral.sh/uv/install.sh"
    "specify-cli"
)

for pattern in "${required_in_dockerfile[@]}"; do
    if grep -q "$pattern" "$dockerfile"; then
        echo "✅ Dockerfile contains: $pattern"
    else
        echo "❌ Dockerfile missing: $pattern"
        exit 1
    fi
done

# Test 6: Check DevContainer JSON has required sections
echo -e "\n6️⃣ Validating DevContainer configuration contents..."
config=".devcontainer/devcontainer.json"

# Extract key values to verify structure
if python3 -c "
import json
with open('$config') as f:
    config = json.load(f)
    
# Check required sections
required = ['name', 'build', 'features', 'customizations', 'remoteUser']
for section in required:
    if section not in config:
        print(f'❌ Missing section: {section}')
        exit(1)
    else:
        print(f'✅ Has section: {section}')

# Check for key features
features = config['features']
if 'ghcr.io/devcontainers/features/python:1' not in features:
    print('❌ Missing Python feature')
    exit(1)
else:
    print('✅ Has Python feature')

if 'ghcr.io/devcontainers/features/git:1' not in features:
    print('❌ Missing Git feature')
    exit(1)
else:
    print('✅ Has Git feature')

# Check VS Code extensions
vscode = config['customizations']['vscode']
extensions = vscode['extensions']
if 'GitHub.copilot' not in extensions:
    print('❌ Missing GitHub Copilot extension')
    exit(1)
else:
    print('✅ Has GitHub Copilot extension')

print('✅ DevContainer configuration is valid')
"; then
    echo "✅ Configuration validation passed"
else
    echo "❌ Configuration validation failed"
    exit 1
fi

echo -e "\n🎉 All tests passed! DevContainer setup appears to be correctly configured."
echo -e "\n📋 Next steps:"
echo "   1. Open this repository in VS Code"
echo "   2. Use 'Dev Containers: Reopen in Container' command"
echo "   3. Wait for container to build and post-create script to run"
echo "   4. Run 'specify check' to verify Spec-Kit installation"
echo "   5. Create your first project with 'specify init my-project --ai copilot'"