// Jest setup file for SpecKitTest
// This file runs before each test file

// Set test timeout
jest.setTimeout(30000);

// Global test utilities
global.testUtils = {
  loadJSON: (filePath) => {
    const fs = require('fs');
    return JSON.parse(fs.readFileSync(filePath, 'utf8'));
  },
  
  validateSchema: (data, schema) => {
    const Ajv = require('ajv');
    const addFormats = require('ajv-formats');
    const ajv = new Ajv({ allErrors: true });
    addFormats(ajv);
    
    const validate = ajv.compile(schema);
    return {
      valid: validate(data),
      errors: validate.errors
    };
  }
};

// Console override for cleaner test output
const originalError = console.error;
console.error = (...args) => {
  if (args[0] && args[0].includes && args[0].includes('Warning')) {
    return;
  }
  originalError.apply(console, args);
};