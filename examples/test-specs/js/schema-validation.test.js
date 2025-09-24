/**
 * JavaScript/Node.js tests for JSON schema validation
 * Demonstrates Spec-Kit testing capabilities with JavaScript
 */

const fs = require('fs');
const path = require('path');
const Ajv = require('ajv');
const addFormats = require('ajv-formats');

describe('Schema Validation Tests', () => {
  let ajv;
  let userSchema;
  
  beforeAll(() => {
    // Initialize AJV with format validation
    ajv = new Ajv({ allErrors: true });
    addFormats(ajv);
    
    // Load the user schema
    const schemaPath = path.join(__dirname, '../../schemas/user.schema.json');
    userSchema = JSON.parse(fs.readFileSync(schemaPath, 'utf8'));
  });

  test('should validate correct user data', () => {
    const validUser = {
      id: 1,
      email: 'test@example.com',
      name: 'Test User',
      age: 25,
      roles: ['user'],
      profile: {
        bio: 'A test user',
        website: 'https://example.com',
        location: 'Test City'
      },
      createdAt: '2023-01-01T00:00:00Z',
      updatedAt: '2023-01-01T00:00:00Z'
    };

    const validate = ajv.compile(userSchema);
    const isValid = validate(validUser);
    
    expect(isValid).toBe(true);
    expect(validate.errors).toBeNull();
  });

  test('should reject user data with invalid email', () => {
    const invalidUser = {
      id: 1,
      email: 'invalid-email', // Invalid email format
      name: 'Test User'
    };

    const validate = ajv.compile(userSchema);
    const isValid = validate(invalidUser);
    
    expect(isValid).toBe(false);
    expect(validate.errors).toBeTruthy();
    expect(validate.errors.some(error => error.instancePath === '/email')).toBe(true);
  });

  test('should reject user data with missing required fields', () => {
    const incompleteUser = {
      id: 1,
      // Missing email and name
    };

    const validate = ajv.compile(userSchema);
    const isValid = validate(incompleteUser);
    
    expect(isValid).toBe(false);
    expect(validate.errors).toBeTruthy();
    expect(validate.errors.length).toBeGreaterThan(0);
  });

  test('should validate user data with optional fields', () => {
    const minimalUser = {
      id: 1,
      email: 'minimal@example.com',
      name: 'Minimal User'
    };

    const validate = ajv.compile(userSchema);
    const isValid = validate(minimalUser);
    
    expect(isValid).toBe(true);
  });

  test('should reject user with invalid role', () => {
    const userWithInvalidRole = {
      id: 1,
      email: 'test@example.com',
      name: 'Test User',
      roles: ['invalid_role'] // Should be one of: admin, user, moderator
    };

    const validate = ajv.compile(userSchema);
    const isValid = validate(userWithInvalidRole);
    
    expect(isValid).toBe(false);
    expect(validate.errors).toBeTruthy();
  });

  test('should validate sample test data from file', () => {
    const testDataPath = path.join(__dirname, '../../test-data/sample-user.json');
    const sampleUser = JSON.parse(fs.readFileSync(testDataPath, 'utf8'));

    const validate = ajv.compile(userSchema);
    const isValid = validate(sampleUser);
    
    if (!isValid) {
      console.log('Validation errors:', validate.errors);
    }
    
    expect(isValid).toBe(true);
  });
});

describe('API Specification Tests', () => {
  test('should have valid OpenAPI specification structure', () => {
    const apiSpecPath = path.join(__dirname, '../../api-specs/sample-api.yaml');
    
    // Check if the API spec file exists
    expect(fs.existsSync(apiSpecPath)).toBe(true);
    
    // In a real test, you would parse and validate the YAML
    const specContent = fs.readFileSync(apiSpecPath, 'utf8');
    expect(specContent).toContain('openapi:');
    expect(specContent).toContain('info:');
    expect(specContent).toContain('paths:');
  });
});

describe('Test Data Validation', () => {
  test('should have consistent test data structure', () => {
    const testDataDir = path.join(__dirname, '../../test-data');
    const files = fs.readdirSync(testDataDir);
    
    expect(files.length).toBeGreaterThan(0);
    expect(files).toContain('sample-user.json');
    
    // Verify each JSON file is valid
    files.filter(file => file.endsWith('.json')).forEach(file => {
      const filePath = path.join(testDataDir, file);
      const content = fs.readFileSync(filePath, 'utf8');
      
      expect(() => JSON.parse(content)).not.toThrow();
    });
  });
});