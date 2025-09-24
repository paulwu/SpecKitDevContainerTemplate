# SpecKitTest

A DevContainer environment for testing and validating Spec-Kit programming. This repository provides a comprehensive development container setup that includes tools and configurations for API specification testing, JSON schema validation, and various programming language environments.

## Features

- 🐳 **DevContainer Support**: Full Visual Studio Code DevContainer configuration
- 🔧 **Multi-Language Environment**: Support for Python, Node.js, Go, and Java
- 📋 **API Testing**: OpenAPI/Swagger specification validation and testing
- 🔍 **Schema Validation**: JSON Schema validation tools and examples
- 🧪 **Testing Frameworks**: pytest, Jest, and other testing tools pre-configured
- 🐘 **Database Testing**: PostgreSQL integration for database-related specifications
- 🛠️ **Developer Tools**: Linting, formatting, and code quality tools

## Quick Start

### Using DevContainer (Recommended)

1. **Prerequisites**: 
   - [Visual Studio Code](https://code.visualstudio.com/)
   - [Docker Desktop](https://www.docker.com/products/docker-desktop/)
   - [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

2. **Open in DevContainer**:
   - Clone this repository
   - Open in VS Code
   - When prompted, click "Reopen in Container" or use Command Palette: `Dev Containers: Reopen in Container`

3. **Verify Setup**:
   ```bash
   # Check installed tools
   python --version
   node --version
   go version
   java -version
   
   # Run sample tests
   pytest examples/test-specs/
   npm test
   ```

### Manual Setup

If you prefer to set up the environment manually:

```bash
# Install Python dependencies
pip install -r requirements.txt

# Install Node.js dependencies
npm install

# Install Go dependencies (if using Go modules)
go mod tidy
```

## Project Structure

```
SpecKitTest/
├── .devcontainer/          # DevContainer configuration
│   ├── devcontainer.json   # Main DevContainer config
│   ├── Dockerfile          # Custom container setup
│   └── docker-compose.yml  # Multi-service setup
├── examples/               # Example specifications and tests
│   ├── api-specs/          # OpenAPI/Swagger specifications
│   ├── test-specs/         # Test files and specifications
│   ├── schemas/            # JSON Schema definitions
│   └── test-data/          # Sample test data
├── package.json            # Node.js dependencies and scripts
├── requirements.txt        # Python dependencies
├── pytest.ini             # pytest configuration
└── README.md              # This file
```

## Usage Examples

### API Specification Testing

```bash
# Validate OpenAPI specification
npm run validate-api

# Run API tests
pytest examples/test-specs/api-test.py -v
```

### JSON Schema Validation

```bash
# Validate JSON data against schema
npm run validate-schema

# Run schema validation tests
pytest examples/test-specs/ -k schema -v
```

### Development Workflow

1. **Write Specifications**: Create your API specs in `examples/api-specs/`
2. **Define Schemas**: Add JSON schemas in `examples/schemas/`
3. **Create Tests**: Write test specifications in `examples/test-specs/`
4. **Validate**: Use the provided scripts to validate your specifications
5. **Test**: Run comprehensive tests to ensure compliance

## Available Scripts

### Python/pytest
```bash
pytest                      # Run all Python tests
pytest --cov               # Run tests with coverage
pytest -k "schema"         # Run only schema-related tests
```

### Node.js/npm
```bash
npm test                   # Run JavaScript tests
npm run lint               # Lint code
npm run format             # Format code
npm run validate-api       # Validate OpenAPI specs
npm run validate-schema    # Validate JSON schemas
```

### Docker Services

The DevContainer includes additional services for testing:

- **PostgreSQL**: Available on port 5432 for database testing
- **Main App**: Your development environment

## Customization

### Adding New Languages

Edit `.devcontainer/devcontainer.json` to add new language features:

```json
"features": {
    "ghcr.io/devcontainers/features/rust:1": {}
}
```

### Adding New Tools

Update the Dockerfile to install additional tools:

```dockerfile
RUN apt-get update && apt-get install -y your-tool
```

### Environment Variables

Create a `.env` file for environment-specific configurations:

```bash
DATABASE_URL=postgresql://speckit:testpass@test-db:5432/speckit_test
API_BASE_URL=http://localhost:8080/api/v1
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test your changes in the DevContainer
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For questions or issues:
- Open an issue on GitHub
- Check the [DevContainers documentation](https://containers.dev/)
- Review the example specifications in the `examples/` directory