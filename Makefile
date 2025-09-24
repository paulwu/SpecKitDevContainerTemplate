# Makefile for SpecKitTest DevContainer Environment

.PHONY: help install test validate clean setup-dev

# Default target
help:
	@echo "Available targets:"
	@echo "  install     - Install all dependencies"
	@echo "  test        - Run all tests"
	@echo "  test-python - Run Python tests only"
	@echo "  test-js     - Run JavaScript tests only"
	@echo "  validate    - Validate all specifications"
	@echo "  lint        - Run linting tools"
	@echo "  format      - Format code"
	@echo "  clean       - Clean build artifacts"
	@echo "  setup-dev   - Set up development environment"

# Install dependencies
install:
	@echo "Installing Python dependencies..."
	pip install -r requirements.txt
	@echo "Installing Node.js dependencies..."
	npm install
	@echo "Dependencies installed successfully!"

# Run all tests
test: test-python test-js

# Run Python tests
test-python:
	@echo "Running Python tests..."
	pytest examples/test-specs/api-test.py -v

# Run JavaScript tests
test-js:
	@echo "Running JavaScript tests..."
	npm test

# Validate specifications
validate:
	@echo "Validating API specifications..."
	-swagger-parser validate examples/api-specs/sample-api.yaml
	@echo "Validating JSON schemas..."
	-ajv validate -s examples/schemas/user.schema.json -d examples/test-data/sample-user.json
	@echo "Validation complete!"

# Lint code
lint:
	@echo "Linting Python code..."
	-flake8 examples/test-specs/
	-mypy examples/test-specs/
	@echo "Linting JavaScript code..."
	-npm run lint
	@echo "Linting complete!"

# Format code
format:
	@echo "Formatting Python code..."
	-black examples/test-specs/
	@echo "Formatting JavaScript code..."
	-npm run format
	@echo "Formatting complete!"

# Clean build artifacts
clean:
	@echo "Cleaning build artifacts..."
	find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	find . -type f -name "*.pyc" -delete 2>/dev/null || true
	rm -rf .pytest_cache/ htmlcov/ .coverage coverage.xml
	rm -rf node_modules/.cache/
	@echo "Clean complete!"

# Set up development environment
setup-dev: install
	@echo "Setting up development environment..."
	@echo "Creating necessary directories..."
	mkdir -p tests logs tmp
	@echo "Development environment ready!"
	@echo ""
	@echo "Quick start commands:"
	@echo "  make test      - Run all tests"
	@echo "  make validate  - Validate specifications"
	@echo "  make lint      - Lint code"