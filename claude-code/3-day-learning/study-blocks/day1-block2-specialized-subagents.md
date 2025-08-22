# Day 1 - Block 2: Specialized Sub-agents
## Learning Objectives
- Master TestWriter sub-agent for automated test generation
- Build Refactorer sub-agent for code improvements
- Create Documenter sub-agent for inline documentation
- Deploy Debugger sub-agent for issue detection
- Implement working examples with production code

## TestWriter Sub-agent

### Core Capabilities
The TestWriter sub-agent specializes in generating comprehensive test suites for your codebase.

### Basic Test Generation

```bash
# Generate tests for a specific file
claude-code "As TestWriter sub-agent:
1. Analyze functions in src/utils.js
2. Generate unit tests covering:
   - Happy path scenarios
   - Edge cases
   - Error handling
   - Boundary conditions
3. Use the existing test framework (detect from package.json)
4. Create src/utils.test.js with complete test suite
5. Ensure 100% code coverage"
```

### Advanced Test Generation with Context

```bash
# Generate integration tests
claude-code "As TestWriter sub-agent:
CONTEXT: This is an Express.js API application

TASK: Generate integration tests for all endpoints
1. Read all route files in src/routes/
2. For each endpoint, create tests for:
   - Valid requests (200 responses)
   - Invalid inputs (400 responses)
   - Authentication failures (401 responses)
   - Authorization failures (403 responses)
   - Server errors (500 responses)
3. Use supertest for API testing
4. Include database setup/teardown
5. Create test/integration/ directory structure
6. Generate comprehensive test suite"
```

### Real-world Example: React Component Testing

```bash
#!/bin/bash
# testwriter-react.sh

claude-code "You are TestWriter sub-agent specialized in React testing.

MISSION: Generate comprehensive tests for React components

WORKFLOW:
1. DISCOVERY PHASE:
   - Scan src/components/ for all .jsx/.tsx files
   - Identify component props and state
   - Detect event handlers and side effects
   - Map component dependencies

2. TEST GENERATION:
   For each component, create tests for:
   - Component rendering with various props
   - User interactions (clicks, inputs, etc.)
   - State changes and updates
   - Conditional rendering logic
   - Error boundaries
   - Accessibility requirements

3. TEST STRUCTURE:
   // UserProfile.test.jsx
   import { render, screen, fireEvent, waitFor } from '@testing-library/react';
   import UserProfile from './UserProfile';
   
   describe('UserProfile Component', () => {
     // Setup and teardown
     // Rendering tests
     // Interaction tests
     // Integration tests
     // Edge cases
   });

4. MOCK GENERATION:
   - Create mocks for API calls
   - Mock external dependencies
   - Setup test data factories

5. COVERAGE VALIDATION:
   - Run coverage report
   - Identify uncovered lines
   - Add tests for missing coverage
   - Target minimum 90% coverage

OUTPUT: Complete test suite in __tests__ directories"
```

## Refactorer Sub-agent

### Code Improvement Patterns

```bash
# Basic refactoring
claude-code "As Refactorer sub-agent:
1. Analyze code complexity in src/
2. Identify code smells:
   - Long methods (>20 lines)
   - Duplicate code blocks
   - Deep nesting (>3 levels)
   - Large classes (>200 lines)
3. Refactor each issue:
   - Extract methods
   - Remove duplication
   - Flatten nested conditions
   - Apply SOLID principles
4. Maintain exact functionality
5. Create refactoring-report.md"
```

### Advanced Refactoring Workflow

```bash
#!/bin/bash
# refactorer-advanced.sh

claude-code "You are Refactorer sub-agent with expertise in clean code.

OBJECTIVE: Transform legacy code into maintainable, modern codebase

ANALYSIS PHASE:
1. Generate complexity metrics for all files
2. Identify anti-patterns:
   - God objects
   - Spaghetti code
   - Copy-paste programming
   - Magic numbers
   - Dead code
3. Create refactoring-plan.json with priorities

REFACTORING PATTERNS:

Pattern 1: Extract Method
- Identify code blocks doing one thing
- Extract into well-named functions
- Add appropriate parameters
- Update all references

Pattern 2: Replace Conditionals with Polymorphism
- Find switch statements on type
- Create class hierarchy
- Move behavior to subclasses
- Simplify client code

Pattern 3: Introduce Parameter Object
- Find methods with >3 parameters
- Group related parameters
- Create value objects
- Update method signatures

Pattern 4: Remove Dead Code
- Find unused variables
- Remove commented code
- Delete unused functions
- Clean up imports

VALIDATION:
1. Run existing tests after each refactoring
2. Ensure no behavior changes
3. Verify performance hasn't degraded
4. Check code coverage maintained

DOCUMENTATION:
- Document each refactoring in changelog
- Update code comments
- Generate before/after comparisons"
```

## Documenter Sub-agent

### Inline Documentation Generation

```bash
# Basic documentation
claude-code "As Documenter sub-agent:
1. Scan all JavaScript files
2. Add JSDoc comments for:
   - All functions (params, returns, examples)
   - Class definitions
   - Complex algorithms
   - Public APIs
3. Follow JSDoc standards
4. Include usage examples
5. Generate documentation site with JSDoc"
```

### Comprehensive Documentation System

```bash
#!/bin/bash
# documenter-comprehensive.sh

claude-code "You are Documenter sub-agent specializing in technical documentation.

MISSION: Create complete documentation system

DOCUMENTATION TYPES:

1. CODE DOCUMENTATION:
   /**
    * Calculates the total price including tax
    * @param {number} price - Base price in cents
    * @param {number} taxRate - Tax rate as decimal (0.08 for 8%)
    * @returns {number} Total price in cents
    * @example
    * calculateTotal(1000, 0.08) // Returns 1080
    */

2. API DOCUMENTATION:
   For each endpoint, document:
   - HTTP method and path
   - Request parameters
   - Request body schema
   - Response schema
   - Error responses
   - Authentication requirements
   - Rate limiting
   - Example requests/responses

3. README SECTIONS:
   - Project overview
   - Installation instructions
   - Configuration options
   - Usage examples
   - API reference
   - Contributing guidelines
   - License information

4. ARCHITECTURE DOCS:
   - System overview diagram
   - Component relationships
   - Data flow diagrams
   - Database schema
   - Deployment architecture

5. DEVELOPER GUIDES:
   - Getting started
   - Development setup
   - Testing procedures
   - Deployment process
   - Troubleshooting

AUTOMATION:
- Generate docs from code
- Create interactive API docs with Swagger
- Build documentation site
- Set up auto-generation in CI/CD"
```

## Debugger Sub-agent

### Issue Detection and Resolution

```bash
# Basic debugging
claude-code "As Debugger sub-agent:
1. Run the application and capture errors
2. Analyze error stack traces
3. Identify root causes:
   - Null pointer exceptions
   - Type mismatches
   - Async/await issues
   - Memory leaks
4. Fix each issue with minimal changes
5. Add error handling where missing
6. Create debugging-report.md"
```

### Advanced Debugging Workflow

```bash
#!/bin/bash
# debugger-advanced.sh

claude-code "You are Debugger sub-agent with deep troubleshooting expertise.

OBJECTIVE: Identify and fix all bugs in the codebase

STATIC ANALYSIS:
1. Run static analysis tools:
   - ESLint for code quality
   - TypeScript compiler for type errors
   - Security scanners for vulnerabilities
2. Catalog all warnings and errors
3. Prioritize by severity

RUNTIME ANALYSIS:
1. Instrument code with logging
2. Add performance monitoring
3. Track memory usage
4. Monitor network requests
5. Capture unhandled exceptions

BUG PATTERNS TO DETECT:

Pattern 1: Race Conditions
- Identify shared state access
- Find missing await keywords
- Detect promise handling issues
- Add proper synchronization

Pattern 2: Memory Leaks
- Find event listeners not removed
- Detect circular references
- Identify large object retention
- Add cleanup code

Pattern 3: Logic Errors
- Boundary condition failures
- Off-by-one errors
- Incorrect boolean logic
- Type coercion issues

Pattern 4: Performance Issues
- N+1 query problems
- Unnecessary re-renders
- Blocking operations
- Inefficient algorithms

DEBUGGING TOOLS:
- Add console.log statements strategically
- Use debugger statements
- Implement error boundaries
- Add performance.mark() calls

FIX VALIDATION:
1. Write test to reproduce bug
2. Apply fix
3. Verify test passes
4. Check for regression
5. Document fix in changelog

OUTPUT:
- Fixed code files
- Test cases for bugs
- Debugging guide
- Performance metrics"
```

## Practical Implementation Examples

### Example 1: Full Test Suite Generation

```bash
# Complete test suite for an Express API
claude-code "As TestWriter sub-agent, generate complete test coverage:

PROJECT CONTEXT:
- Express.js REST API
- PostgreSQL database
- JWT authentication
- Rate limiting

GENERATE TESTS FOR:
1. Authentication flow:
   - User registration
   - Login/logout
   - Token refresh
   - Password reset

2. CRUD operations:
   - Create with validation
   - Read with pagination
   - Update with permissions
   - Delete with soft delete

3. Edge cases:
   - Concurrent updates
   - Rate limit exceeded
   - Database connection loss
   - Invalid JWT tokens

4. Performance tests:
   - Load testing endpoints
   - Stress testing database
   - Memory leak detection

Use Jest, Supertest, and create fixtures for test data."
```

### Example 2: Legacy Code Refactoring

```bash
# Refactor jQuery spaghetti code to modern JavaScript
claude-code "As Refactorer sub-agent, modernize legacy jQuery application:

CURRENT STATE:
- 5000+ lines of jQuery in single file
- Global variables everywhere
- Callback hell
- No module system

TARGET STATE:
- ES6 modules
- Modern async/await
- Component-based structure
- No global pollution

REFACTORING STEPS:
1. Extract inline scripts to separate files
2. Convert jQuery selectors to querySelector
3. Replace $.ajax with fetch API
4. Convert callbacks to promises
5. Group related functions into modules
6. Add TypeScript definitions
7. Implement error boundaries
8. Add loading states
9. Remove dead code
10. Optimize bundle size

Maintain 100% backward compatibility."
```

### Example 3: API Documentation Generation

```bash
# Generate OpenAPI specification
claude-code "As Documenter sub-agent, create comprehensive API docs:

1. Scan all route files
2. Extract endpoint information
3. Generate OpenAPI 3.0 spec:
   - Path definitions
   - Request/response schemas
   - Authentication requirements
   - Error responses
4. Create Postman collection
5. Generate client SDKs:
   - JavaScript/TypeScript
   - Python
   - Go
6. Create interactive docs with Swagger UI
7. Add code examples for each endpoint
8. Include rate limiting information
9. Document webhooks
10. Create API changelog"
```

## Combining Specialized Sub-agents

```bash
#!/bin/bash
# combined-workflow.sh

# Step 1: Debug first
claude-code "As Debugger: Fix all errors and warnings in the codebase"

# Step 2: Refactor clean
claude-code "As Refactorer: Improve code quality and reduce complexity"

# Step 3: Document everything
claude-code "As Documenter: Add comprehensive documentation"

# Step 4: Test thoroughly
claude-code "As TestWriter: Achieve 95% test coverage"

# Step 5: Validate
claude-code "Verify all tests pass and documentation is complete"
```

## Practice Exercises

### Exercise 1: Build a Migration Testing Sub-agent
Create a sub-agent that generates tests specifically for database migrations.

### Exercise 2: Create a Security Auditor Sub-agent
Build a sub-agent that identifies and fixes security vulnerabilities.

### Exercise 3: Design a Performance Optimizer Sub-agent
Develop a sub-agent that profiles and optimizes application performance.

## Key Takeaways

1. **Specialized sub-agents excel at focused tasks**
2. **Combine multiple sub-agents for comprehensive workflows**
3. **Always validate changes with tests**
4. **Documentation should be generated, not manual**
5. **Debugging should be systematic and thorough**

## Next Steps

Block 3 will cover orchestration patterns for coordinating multiple sub-agents in complex workflows.