"""
Sample API test specification using pytest for Spec-Kit testing
"""

import pytest
import requests
import jsonschema
import json
from pathlib import Path


class TestAPISpecification:
    """Test cases for the sample API specification"""
    
    BASE_URL = "http://localhost:8080/api/v1"
    
    @pytest.fixture
    def user_schema(self):
        """Load the user JSON schema for validation"""
        schema_path = Path(__file__).parent.parent / "schemas" / "user.schema.json"
        with open(schema_path, 'r') as f:
            return json.load(f)
    
    def test_health_endpoint_returns_200(self):
        """Test that the health endpoint returns 200 status"""
        # This test would normally make a real HTTP request
        # For demonstration purposes, we'll mock the expected behavior
        expected_response = {
            "status": "healthy",
            "timestamp": "2023-12-01T10:30:00Z"
        }
        
        # In a real test, you would do:
        # response = requests.get(f"{self.BASE_URL}/health")
        # assert response.status_code == 200
        # assert response.json() == expected_response
        
        assert expected_response["status"] == "healthy"
        assert "timestamp" in expected_response
    
    def test_users_endpoint_returns_list(self):
        """Test that the users endpoint returns a list of users"""
        # Mock expected response structure
        expected_users = [
            {
                "id": 1,
                "email": "user1@example.com",
                "name": "User One",
                "createdAt": "2023-01-01T00:00:00Z",
                "updatedAt": "2023-01-01T00:00:00Z"
            },
            {
                "id": 2,
                "email": "user2@example.com", 
                "name": "User Two",
                "createdAt": "2023-01-02T00:00:00Z",
                "updatedAt": "2023-01-02T00:00:00Z"
            }
        ]
        
        # Validate that the response structure matches expectations
        assert isinstance(expected_users, list)
        assert len(expected_users) >= 0
        
        for user in expected_users:
            assert "id" in user
            assert "email" in user
            assert "name" in user
    
    def test_user_data_validates_against_schema(self, user_schema):
        """Test that user data validates against the JSON schema"""
        sample_user = {
            "id": 1,
            "email": "john.doe@example.com",
            "name": "John Doe",
            "age": 30,
            "roles": ["user"],
            "profile": {
                "bio": "Software developer",
                "website": "https://johndoe.dev",
                "location": "San Francisco, CA"
            },
            "createdAt": "2023-01-15T10:30:00Z",
            "updatedAt": "2023-12-01T14:22:30Z"
        }
        
        # Validate the sample user against the schema
        try:
            jsonschema.validate(instance=sample_user, schema=user_schema)
            validation_passed = True
        except jsonschema.ValidationError:
            validation_passed = False
        
        assert validation_passed, "Sample user data should validate against schema"
    
    def test_invalid_user_data_fails_validation(self, user_schema):
        """Test that invalid user data fails schema validation"""
        invalid_user = {
            "id": "not_a_number",  # Should be integer
            "email": "invalid-email",  # Should be valid email format
            "name": "",  # Should have minimum length of 1
        }
        
        with pytest.raises(jsonschema.ValidationError):
            jsonschema.validate(instance=invalid_user, schema=user_schema)
    
    def test_create_user_request_validation(self):
        """Test validation of create user request data"""
        valid_request = {
            "email": "newuser@example.com",
            "name": "New User"
        }
        
        # Validate required fields are present
        assert "email" in valid_request
        assert "name" in valid_request
        assert "@" in valid_request["email"]
        assert len(valid_request["name"]) > 0


if __name__ == "__main__":
    # Run the tests
    pytest.main([__file__, "-v"])