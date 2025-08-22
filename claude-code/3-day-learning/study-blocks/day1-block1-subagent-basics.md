# Day 1 - Block 1: Sub-agent Basics
## Learning Objectives
- Understand Claude Code CLI sub-agents architecture
- Master basic sub-agent syntax and commands
- Create and deploy your first sub-agent
- Learn sub-agent communication patterns

## What are Claude Code Sub-agents?

Sub-agents are specialized AI assistants that you can spawn from the main Claude Code CLI to handle specific tasks. They operate independently but can communicate with the parent agent through structured prompts and responses.

### Core Concepts

1. **Sub-agent**: A focused AI instance handling a specific domain or task
2. **Parent Agent**: The main Claude Code CLI instance orchestrating sub-agents
3. **Context Passing**: Sharing information between agents
4. **Task Isolation**: Each sub-agent operates in its own context window

## Basic Sub-agent Syntax

### Creating a Simple Sub-agent

```bash
# Basic sub-agent invocation
claude-code "Act as a FileAnalyzer sub-agent. Analyze all Python files in the src/ directory and report code quality metrics."

# Sub-agent with specific role
claude-code --role "Code Reviewer" "Review the changes in the last commit and provide feedback on code quality, potential bugs, and improvements."

# Sub-agent with context file
claude-code --context analyze.md "Execute the analysis workflow defined in the context file."
```

### Sub-agent Command Patterns

```bash
# Pattern 1: Direct Task Assignment
claude-code "As a TestGenerator sub-agent, create unit tests for all functions in utils.py"

# Pattern 2: Pipeline Sub-agent
claude-code "Process this request through multiple steps:
1. Analyze the code structure
2. Identify missing tests
3. Generate test cases
4. Write test files"

# Pattern 3: Conditional Sub-agent
claude-code "If the project uses TypeScript, add type definitions. Otherwise, add JSDoc comments."
```

## Creating Your First Sub-agent

### Example 1: FileAnalyzer Sub-agent

```bash
# Create a file analyzer sub-agent
claude-code "You are FileAnalyzer sub-agent. Your task:
1. List all JavaScript files in the current directory
2. Count lines of code in each file
3. Identify files without proper documentation
4. Generate a report in analysis-report.md

Use these specific rules:
- Consider a file documented if it has a header comment
- Count only non-empty, non-comment lines
- Format the report as a markdown table"
```

### Example 2: CodeReviewer Sub-agent

```bash
# Create a code review sub-agent
claude-code "You are CodeReviewer sub-agent. Perform these tasks:
1. Check the git diff for the last commit
2. Review for:
   - Code style consistency
   - Potential bugs
   - Performance issues
   - Security concerns
3. Create review-comments.md with findings
4. Suggest specific improvements with code examples"
```

## Sub-agent Communication Patterns

### Pattern 1: Sequential Processing

```bash
# First sub-agent analyzes
claude-code "As Analyzer sub-agent: Scan all .js files and create file-list.json with complexity metrics"

# Second sub-agent uses the output
claude-code "As Optimizer sub-agent: Read file-list.json and optimize files with complexity > 10"
```

### Pattern 2: Parallel Execution

```bash
# Launch multiple sub-agents simultaneously
claude-code "As DocGenerator: Create API docs for all endpoints" &
claude-code "As TestWriter: Generate tests for all controllers" &
claude-code "As Linter: Fix all linting issues in the codebase" &
wait
```

### Pattern 3: Hierarchical Sub-agents

```bash
# Parent coordinator
claude-code "You are the Coordinator sub-agent. Your workflow:
1. Spawn Analyzer sub-agent to assess the codebase
2. Based on analysis, spawn appropriate specialized sub-agents:
   - If tests < 80% coverage: Spawn TestWriter
   - If documentation missing: Spawn DocGenerator
   - If performance issues: Spawn Optimizer
3. Collect all sub-agent reports
4. Generate master-report.md"
```

## Working Examples

### Complete File Processing Sub-agent

```bash
#!/bin/bash
# file-processor-subagent.sh

claude-code "You are FileProcessor sub-agent. Execute this workflow:

INITIALIZATION:
- Create processing-log.md
- Log start time and parameters

FILE DISCOVERY:
- Find all .js and .ts files recursively
- Exclude node_modules and build directories
- Create file-inventory.json

PROCESSING:
For each file in inventory:
1. Check if it has proper imports
2. Verify export statements
3. Add missing 'use strict' directives
4. Ensure consistent indentation
5. Log changes to processing-log.md

VALIDATION:
- Run 'npm run lint' to verify changes
- If errors, fix them automatically
- Re-run until no errors

REPORTING:
- Generate processing-report.md with:
  - Files processed
  - Changes made
  - Errors fixed
  - Time taken
  
Use tools: Read, Edit, Bash, Write"
```

### Intelligent Code Migration Sub-agent

```bash
#!/bin/bash
# migration-subagent.sh

claude-code "You are MigrationAgent. Migrate the codebase from CommonJS to ES6 modules:

ANALYSIS PHASE:
1. Identify all .js files using require()
2. Map all module.exports patterns
3. Create migration-plan.json with:
   - Files to migrate
   - Dependency graph
   - Risk assessment

MIGRATION PHASE:
For each file in migration plan:
1. Convert require() to import statements
2. Convert module.exports to export statements
3. Update file extension to .mjs if needed
4. Preserve functionality exactly

TESTING PHASE:
1. Run existing tests
2. Fix any broken imports
3. Verify no functionality changed
4. Generate migration-report.md

ROLLBACK CAPABILITY:
- Create backup of each file before changes
- If tests fail, provide rollback command
- Log all changes for audit trail"
```

## Practice Exercises

### Exercise 1: Create a Security Scanner Sub-agent
```bash
# Your task: Create a sub-agent that:
# 1. Scans for hardcoded credentials
# 2. Identifies SQL injection vulnerabilities
# 3. Checks for exposed API keys
# 4. Generates security-report.md
```

### Exercise 2: Build a Performance Optimizer Sub-agent
```bash
# Your task: Create a sub-agent that:
# 1. Identifies slow database queries
# 2. Finds N+1 query problems
# 3. Suggests caching strategies
# 4. Implements basic optimizations
```

### Exercise 3: Design a Dependency Updater Sub-agent
```bash
# Your task: Create a sub-agent that:
# 1. Checks for outdated packages
# 2. Reviews breaking changes
# 3. Updates dependencies safely
# 4. Runs tests after each update
```

## Key Takeaways

1. **Sub-agents are specialized workers** - Each handles a specific domain
2. **Clear prompts are crucial** - Be specific about tasks and outputs
3. **Context management matters** - Pass necessary information explicitly
4. **Error handling is essential** - Always include validation and rollback
5. **Composition over complexity** - Chain simple sub-agents for complex tasks

## Next Steps

In Block 2, we'll explore specialized sub-agents for:
- Test generation
- Code refactoring
- Documentation
- Debugging

Each with real-world examples and production-ready patterns.