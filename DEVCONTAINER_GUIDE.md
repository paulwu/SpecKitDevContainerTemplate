# DevContainer Usage Guide

This guide explains how to use the SpecKitTest DevContainer environment for testing and validating specifications.

## Getting Started

### 1. Prerequisites

- [Visual Studio Code](https://code.visualstudio.com/)
- [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

### 2. Opening the DevContainer

1. Clone this repository:
   ```bash
   git clone https://github.com/paulwu/SpecKitTest.git
   cd SpecKitTest
   ```

2. Open VS Code:
   ```bash
   code .
   ```

3. When prompted, click **"Reopen in Container"** or:
   - Press `Ctrl+Shift+P` (or `Cmd+Shift+P` on Mac)
   - Type "Dev Containers: Reopen in Container"
   - Press Enter

### 3. First Time Setup

The DevContainer will automatically:
- Install all language runtimes (Python, Node.js, Go, Java)
- Install development tools and extensions
- Set up the environment
- Run the post-create command to verify installation

Wait for the container to build (first time may take 5-10 minutes).

## Available Tools and Commands

### Quick Start Commands

```bash
# Install all dependencies
make install

# Run all tests
make test

# Run Python tests only
make test-python

# Run JavaScript tests only  
make test-js

# Validate specifications
make validate

# Lint code
make lint

# Format code
make format
```

### Python Environment

```bash
# Python version
python --version

# Run pytest
pytest examples/test-specs/api-test.py -v

# Install Python packages
pip install package-name

# Check installed packages
pip list
```

### Node.js Environment

```bash
# Node.js version
node --version
npm --version

# Run Jest tests
npm test

# Install npm packages
npm install package-name

# Lint JavaScript code
npm run lint
```

### Go Environment

```bash
# Go version
go version

# Initialize Go module (if needed)
go mod init your-module-name

# Install Go packages
go get package-name
```

### Java Environment

```bash
# Java version
java -version

# Maven (if available)
mvn --version
```

## Project Structure

```
SpecKitTest/
├── .devcontainer/                 # DevContainer configuration
│   ├── devcontainer.json         # Main configuration
│   ├── Dockerfile                # Custom container setup
│   └── docker-compose.yml        # Multi-service setup
├── examples/                     # Example specifications
│   ├── api-specs/               # OpenAPI specifications
│   ├── schemas/                 # JSON schemas
│   ├── test-data/              # Sample test data
│   └── test-specs/             # Test files
├── .vscode/                      # VS Code settings
│   └── tasks.json              # Predefined tasks
├── Makefile                      # Build commands
├── package.json                  # Node.js dependencies
├── requirements.txt              # Python dependencies
└── README.md                     # Main documentation
```

## Example Workflows

### 1. API Specification Testing

```bash
# Create a new API spec
cp examples/api-specs/sample-api.yaml examples/api-specs/my-api.yaml

# Edit the specification
code examples/api-specs/my-api.yaml

# Validate the specification
swagger-parser validate examples/api-specs/my-api.yaml

# Create tests for the API
cp examples/test-specs/api-test.py examples/test-specs/my-api-test.py

# Run the tests
pytest examples/test-specs/my-api-test.py -v
```

### 2. JSON Schema Validation

```bash
# Create a new schema
cp examples/schemas/user.schema.json examples/schemas/product.schema.json

# Edit the schema
code examples/schemas/product.schema.json

# Create test data
echo '{"id": 1, "name": "Test Product"}' > examples/test-data/sample-product.json

# Validate data against schema
ajv validate -s examples/schemas/product.schema.json -d examples/test-data/sample-product.json
```

### 3. Multi-Language Testing

```bash
# Python testing
pytest examples/test-specs/ -v --cov

# JavaScript testing  
npm test

# Run both
make test
```

## VS Code Features

### Predefined Tasks

Press `Ctrl+Shift+P` and type "Tasks: Run Task" to access:

- **Install Dependencies**: Install all project dependencies
- **Run All Tests**: Execute both Python and JavaScript tests
- **Run Python Tests**: Execute only Python tests
- **Run JavaScript Tests**: Execute only JavaScript tests
- **Validate Specifications**: Validate API specs and schemas
- **Lint Code**: Run code linting tools
- **Format Code**: Format code using standard tools

### Extensions Included

- **Python**: Full Python development support
- **JavaScript/TypeScript**: Node.js development tools
- **Go**: Go language support
- **Java**: Java development pack
- **JSON/YAML**: Schema validation and editing
- **Docker**: Container management
- **GitHub Copilot**: AI-powered coding assistance

### Debugging

The DevContainer includes debugging support for:
- Python (pytest, FastAPI apps)
- Node.js (Jest tests, Express apps)
- Go applications
- Java applications

## Database Testing

A PostgreSQL container is available for database-related specifications:

```bash
# Connection details
Host: test-db
Port: 5432
Database: speckit_test
Username: speckit  
Password: testpass

# Connect using psql
psql -h test-db -U speckit -d speckit_test
```

## Troubleshooting

### Container Build Issues

```bash
# Rebuild container
Ctrl+Shift+P -> "Dev Containers: Rebuild Container"

# or rebuild without cache
Ctrl+Shift+P -> "Dev Containers: Rebuild Container Without Cache"
```

### Port Conflicts

The DevContainer exposes these ports:
- 3000: Frontend applications
- 8000: Python web applications  
- 8080: General web applications
- 9000: Additional services

### Performance Issues

- Ensure Docker Desktop has sufficient resources (4GB+ RAM recommended)
- Close unused applications to free system resources
- Consider using Docker Desktop's resource limits

### Extension Issues

If VS Code extensions don't load properly:
1. Reload the window: `Ctrl+Shift+P` -> "Developer: Reload Window"
2. Check the Extensions view for any error messages
3. Rebuild the container if issues persist

## Customization

### Adding New Languages

Edit `.devcontainer/devcontainer.json`:

```json
"features": {
    "ghcr.io/devcontainers/features/rust:1": {},
    "ghcr.io/devcontainers/features/php:1": {}
}
```

### Adding New Tools

Edit `.devcontainer/Dockerfile`:

```dockerfile
RUN apt-get update && apt-get install -y \
    your-tool-name \
    another-tool
```

### Custom Environment Variables

Create `.devcontainer/.env`:

```bash
API_KEY=your-api-key
DATABASE_URL=postgresql://user:pass@host:port/db
```

## Support

- Review the example files in `examples/`
- Check the main [README.md](README.md) for detailed documentation
- Open issues on GitHub for bugs or feature requests
- Consult the [DevContainers documentation](https://containers.dev/) for advanced configuration