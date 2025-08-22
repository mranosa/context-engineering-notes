#!/bin/bash
# example-test-generator.sh - Sub-agent for test generation
# This script demonstrates a test generation sub-agent that creates
# comprehensive test suites for your code

# Function to display usage
show_usage() {
    echo "Usage: $0 [OPTIONS]"
    echo "Options:"
    echo "  -f, --file FILE        File to generate tests for"
    echo "  -d, --directory DIR    Directory to process (default: src)"
    echo "  -t, --type TYPE        Test type (unit, integration, e2e)"
    echo "  -r, --framework FRAME  Test framework (jest, mocha, pytest)"
    echo "  -c, --coverage TARGET  Target coverage percentage (default: 80)"
    echo "  -h, --help            Show this help message"
}

# Default values
FILE=""
DIRECTORY="src"
TEST_TYPE="unit"
FRAMEWORK="jest"
COVERAGE=80

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -f|--file)
            FILE="$2"
            shift 2
            ;;
        -d|--directory)
            DIRECTORY="$2"
            shift 2
            ;;
        -t|--type)
            TEST_TYPE="$2"
            shift 2
            ;;
        -r|--framework)
            FRAMEWORK="$2"
            shift 2
            ;;
        -c|--coverage)
            COVERAGE="$2"
            shift 2
            ;;
        -h|--help)
            show_usage
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            show_usage
            exit 1
            ;;
    esac
done

# Test Generator Sub-agent
run_test_generator() {
    claude-code "You are TestGenerator sub-agent. Generate comprehensive tests:

TEST GENERATION CONTEXT:
- Target: ${FILE:-"All files in $DIRECTORY"}
- Test Type: $TEST_TYPE
- Framework: $FRAMEWORK
- Coverage Target: $COVERAGE%

PHASE 1: CODE ANALYSIS
$(if [ -n "$FILE" ]; then
    echo "Analyze single file: $FILE"
else
    echo "Scan all files in $DIRECTORY"
fi)

1. Identify testable units:
   - Functions and methods
   - Classes and constructors
   - Exported modules
   - API endpoints
   - React/Vue components

2. Analyze code patterns:
   - Input parameters
   - Return types
   - Side effects
   - Dependencies
   - Error conditions

3. Create test-plan.json with:
   - List of test targets
   - Test categories needed
   - Mock requirements
   - Fixture data needs

PHASE 2: TEST GENERATION BY TYPE

$(case $TEST_TYPE in
    unit)
        echo "UNIT TEST GENERATION:
For each function/method:
1. Happy path tests
   - Valid inputs
   - Expected outputs
   - Normal flow

2. Edge cases
   - Boundary values
   - Empty inputs
   - Maximum values
   - Minimum values

3. Error cases
   - Invalid inputs
   - Null/undefined
   - Type mismatches
   - Exception handling

4. State tests (for classes)
   - Initial state
   - State transitions
   - State persistence

Example for $FRAMEWORK:
$(case $FRAMEWORK in
    jest)
        echo "describe('functionName', () => {
  beforeEach(() => {
    // Setup
  });

  it('should handle normal input', () => {
    const result = functionName('input');
    expect(result).toBe('expected');
  });

  it('should throw on invalid input', () => {
    expect(() => functionName(null)).toThrow();
  });

  it('should handle edge cases', () => {
    expect(functionName('')).toBe(defaultValue);
  });
});"
        ;;
    mocha)
        echo "describe('functionName', function() {
  beforeEach(function() {
    // Setup
  });

  it('should handle normal input', function() {
    const result = functionName('input');
    assert.equal(result, 'expected');
  });

  it('should throw on invalid input', function() {
    assert.throws(() => functionName(null));
  });
});"
        ;;
    pytest)
        echo "import pytest

class TestFunction:
    def setup_method(self):
        # Setup
        pass

    def test_normal_input(self):
        result = function_name('input')
        assert result == 'expected'

    def test_invalid_input(self):
        with pytest.raises(ValueError):
            function_name(None)

    def test_edge_cases(self):
        assert function_name('') == default_value"
        ;;
esac)"
        ;;
    integration)
        echo "INTEGRATION TEST GENERATION:
1. API endpoint tests
   - HTTP methods (GET, POST, PUT, DELETE)
   - Status codes
   - Response bodies
   - Headers
   - Authentication

2. Database operations
   - CRUD operations
   - Transactions
   - Relationships
   - Constraints

3. Service interactions
   - Service calls
   - Data flow
   - Error propagation

Example:
describe('API Integration', () => {
  it('should create and retrieve user', async () => {
    const user = await api.post('/users', userData);
    const retrieved = await api.get(\`/users/\${user.id}\`);
    expect(retrieved).toEqual(user);
  });
});"
        ;;
    e2e)
        echo "END-TO-END TEST GENERATION:
1. User workflows
   - Complete user journeys
   - Multi-step processes
   - Cross-feature interactions

2. UI interactions
   - Form submissions
   - Navigation flows
   - Dynamic content

3. Business scenarios
   - Real-world use cases
   - Error recovery
   - Edge workflows

Example:
describe('User Registration Flow', () => {
  it('should complete registration', async () => {
    await page.goto('/register');
    await page.fill('#email', 'test@example.com');
    await page.fill('#password', 'SecurePass123');
    await page.click('#submit');
    await expect(page).toHaveURL('/dashboard');
  });
});"
        ;;
esac)

PHASE 3: MOCK AND FIXTURE GENERATION

1. Generate mocks for:
   - External services
   - Database connections
   - File system operations
   - Network requests
   - Time-dependent functions

2. Create fixtures:
   - Test data sets
   - Sample responses
   - Error scenarios
   - Edge case data

Example fixtures:
// fixtures/users.json
{
  \"validUser\": {
    \"id\": 1,
    \"name\": \"Test User\",
    \"email\": \"test@example.com\"
  },
  \"invalidUser\": {
    \"id\": null,
    \"name\": \"\",
    \"email\": \"invalid-email\"
  }
}

PHASE 4: TEST ORGANIZATION

Create test structure:
$(case $FRAMEWORK in
    jest)
        echo "
__tests__/
├── unit/
│   ├── services/
│   ├── utils/
│   └── components/
├── integration/
│   ├── api/
│   └── database/
├── e2e/
│   └── workflows/
├── fixtures/
├── mocks/
└── helpers/"
        ;;
    pytest)
        echo "
tests/
├── unit/
│   ├── test_services.py
│   ├── test_utils.py
│   └── test_models.py
├── integration/
│   ├── test_api.py
│   └── test_database.py
├── e2e/
│   └── test_workflows.py
├── fixtures/
├── conftest.py
└── helpers/"
        ;;
esac)

PHASE 5: COVERAGE ANALYSIS

1. Run generated tests
2. Measure coverage:
   - Line coverage
   - Branch coverage
   - Function coverage
   - Statement coverage

3. Identify gaps:
   - Uncovered lines
   - Untested branches
   - Missing edge cases

4. Generate additional tests for gaps
5. Iterate until $COVERAGE% reached

PHASE 6: TEST QUALITY ASSURANCE

1. Validate tests:
   - No false positives
   - Meaningful assertions
   - Proper isolation
   - Deterministic results

2. Optimize tests:
   - Remove redundancy
   - Improve performance
   - Reduce flakiness

3. Documentation:
   - Clear test names
   - Descriptive comments
   - Usage examples

PHASE 7: REPORTING

Generate test-generation-report.md with:
- Tests generated: count by type
- Coverage achieved: before/after
- Files tested: complete list
- Mocks created
- Fixtures generated
- Run instructions
- CI/CD integration guide

EXECUTION COMMANDS:
$(case $FRAMEWORK in
    jest)
        echo "
# Run all tests
npm test

# Run with coverage
npm test -- --coverage

# Run specific file
npm test -- $FILE.test.js

# Watch mode
npm test -- --watch"
        ;;
    mocha)
        echo "
# Run all tests
npm test

# Run with coverage
nyc npm test

# Run specific file
mocha $FILE.test.js"
        ;;
    pytest)
        echo "
# Run all tests
pytest

# Run with coverage
pytest --cov=src

# Run specific file
pytest tests/test_$FILE.py

# Verbose output
pytest -v"
        ;;
esac)

SUCCESS CRITERIA:
- All critical paths tested
- Coverage >= $COVERAGE%
- No test failures
- Tests run in < 60 seconds
- Clear test documentation"
}

# Main execution
echo "Starting Test Generator Sub-agent..."
echo "Test Type: $TEST_TYPE"
echo "Framework: $FRAMEWORK"
echo "Coverage Target: $COVERAGE%"
if [ -n "$FILE" ]; then
    echo "Target File: $FILE"
else
    echo "Target Directory: $DIRECTORY"
fi
echo "----------------------------------------"

# Run the sub-agent
run_test_generator

echo "----------------------------------------"
echo "Test generation complete!"
echo "Check test-generation-report.md for details."
echo "Run tests with the commands provided in the report."