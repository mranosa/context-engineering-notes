# Day 1 - Block 3: Sub-agent Orchestration
## Learning Objectives
- Master chaining multiple sub-agents
- Implement parallel sub-agent execution
- Build sub-agent pipelines
- Handle context passing between sub-agents
- Design robust error handling workflows

## Fundamentals of Orchestration

### What is Sub-agent Orchestration?
Orchestration involves coordinating multiple sub-agents to accomplish complex tasks that require different specialized capabilities. Think of it as conducting an orchestra where each musician (sub-agent) plays their part at the right time.

### Key Orchestration Patterns

1. **Sequential Chain**: Sub-agents execute one after another
2. **Parallel Execution**: Multiple sub-agents work simultaneously
3. **Conditional Branching**: Sub-agents chosen based on conditions
4. **Map-Reduce**: Distribute work and aggregate results
5. **Pipeline**: Data flows through transformation stages

## Sequential Chaining

### Basic Sequential Chain

```bash
#!/bin/bash
# sequential-chain.sh

# Step 1: Analyze the codebase
claude-code "As Analyzer sub-agent:
1. Scan all source files
2. Generate metrics.json with:
   - File count by type
   - Lines of code
   - Complexity scores
   - Test coverage
3. Identify top 5 files needing attention"

# Step 2: Refactor based on analysis
claude-code "As Refactorer sub-agent:
1. Read metrics.json
2. Refactor the top 5 complex files:
   - Extract long methods
   - Reduce cyclomatic complexity
   - Improve naming
3. Create refactoring-log.md"

# Step 3: Generate tests for refactored code
claude-code "As TestWriter sub-agent:
1. Read refactoring-log.md
2. Generate tests for all refactored methods
3. Ensure tests pass
4. Update coverage report"

# Step 4: Document changes
claude-code "As Documenter sub-agent:
1. Read refactoring-log.md
2. Update documentation for changed APIs
3. Generate migration guide
4. Update changelog"
```

### Advanced Sequential Pipeline

```bash
#!/bin/bash
# advanced-pipeline.sh

claude-code "You are the Orchestrator. Execute this pipeline:

PIPELINE DEFINITION:
Name: CodeQualityPipeline
Stages: Analysis -> Cleaning -> Enhancement -> Validation -> Deployment

STAGE 1: Analysis
Sub-agent: CodeAnalyzer
Input: Source code directory
Tasks:
  - Identify code smells
  - Find security vulnerabilities  
  - Detect performance bottlenecks
  - Check dependency issues
Output: analysis-report.json

STAGE 2: Cleaning  
Sub-agent: CodeCleaner
Input: analysis-report.json
Tasks:
  - Remove dead code
  - Fix linting errors
  - Standardize formatting
  - Update deprecated APIs
Output: cleaning-log.json

STAGE 3: Enhancement
Sub-agent: CodeEnhancer  
Input: cleaning-log.json
Tasks:
  - Add type safety
  - Implement error handling
  - Optimize algorithms
  - Add caching layers
Output: enhancement-log.json

STAGE 4: Validation
Sub-agent: QualityValidator
Input: enhancement-log.json
Tasks:
  - Run test suite
  - Check coverage > 80%
  - Verify performance benchmarks
  - Security scan
Output: validation-report.json

STAGE 5: Deployment
Sub-agent: DeploymentManager
Input: validation-report.json
Tasks:
  - Create release notes
  - Tag version
  - Build artifacts
  - Update documentation
Output: deployment-summary.json

ERROR HANDLING:
- If any stage fails, stop pipeline
- Log failure details
- Create rollback plan
- Notify about failure

SUCCESS HANDLING:
- Generate pipeline-success-report.md
- Include metrics from all stages
- Create visualization of improvements"
```

## Parallel Execution

### Basic Parallel Pattern

```bash
#!/bin/bash
# parallel-execution.sh

# Launch multiple sub-agents in parallel
(
  claude-code "As Frontend sub-agent: Build React components for the new feature" &
  claude-code "As Backend sub-agent: Create API endpoints for the feature" &
  claude-code "As Database sub-agent: Design and implement schema changes" &
  claude-code "As Testing sub-agent: Create test scenarios and fixtures" &
  wait
)

# Combine results
claude-code "As Integration sub-agent: 
1. Read outputs from all parallel sub-agents
2. Integrate frontend with backend
3. Connect to database
4. Run integration tests
5. Generate integration-report.md"
```

### Advanced Parallel Workflow

```bash
#!/bin/bash
# parallel-advanced.sh

claude-code "You are ParallelOrchestrator. Execute parallel workflows:

PARALLEL WORKFLOW: Multi-Language Migration

CONFIGURE WORKERS:
Workers: 5
Timeout: 10 minutes
RetryOnFailure: true

PARALLEL TASKS:

Worker 1: JavaScriptMigrator
- Migrate .js files to TypeScript
- Add type definitions
- Update imports/exports
- Output: js-migration.log

Worker 2: PythonMigrator  
- Upgrade Python 2 to Python 3
- Fix compatibility issues
- Update dependencies
- Output: py-migration.log

Worker 3: DatabaseMigrator
- Update SQL schemas
- Migrate stored procedures
- Optimize queries
- Output: db-migration.log

Worker 4: ConfigMigrator
- Update configuration files
- Migrate environment variables
- Update deployment scripts
- Output: config-migration.log

Worker 5: DocumentationUpdater
- Update API documentation
- Revise setup guides
- Update examples
- Output: docs-update.log

SYNCHRONIZATION POINTS:
1. Wait for all workers to complete
2. Collect all output logs
3. Check for conflicts
4. Resolve dependencies

AGGREGATION:
- Combine all migration logs
- Generate unified report
- Create rollback scripts
- Update project README

CONFLICT RESOLUTION:
If conflicts detected:
1. Identify conflicting changes
2. Apply resolution strategy:
   - Use newest for configs
   - Merge for documentation
   - Manual review for code
3. Re-run affected workers
4. Validate resolution"
```

## Sub-agent Pipelines

### Data Processing Pipeline

```bash
#!/bin/bash
# data-pipeline.sh

claude-code "Create a data processing pipeline:

PIPELINE: UserDataProcessor

Stage 1: DataExtractor
INPUT: Raw database dump
PROCESS:
  - Parse SQL dump file
  - Extract user tables
  - Convert to JSON format
OUTPUT: users-raw.json

Stage 2: DataCleaner
INPUT: users-raw.json  
PROCESS:
  - Remove duplicates
  - Fix inconsistent formats
  - Validate email addresses
  - Normalize phone numbers
OUTPUT: users-clean.json

Stage 3: DataEnricher
INPUT: users-clean.json
PROCESS:
  - Add geolocation data
  - Calculate user segments
  - Append social media info
  - Add behavioral metrics  
OUTPUT: users-enriched.json

Stage 4: DataTransformer
INPUT: users-enriched.json
PROCESS:
  - Apply business rules
  - Calculate derived fields
  - Create aggregations
  - Format for export
OUTPUT: users-final.json

Stage 5: DataLoader
INPUT: users-final.json
PROCESS:
  - Validate against schema
  - Load into database
  - Update search index
  - Clear caches
OUTPUT: load-summary.json

PIPELINE FEATURES:
- Checkpoint after each stage
- Resume from last checkpoint on failure
- Parallel processing where possible
- Progress reporting
- Data quality metrics"
```

### Build and Deploy Pipeline

```bash
#!/bin/bash
# build-deploy-pipeline.sh

claude-code "Implement CI/CD pipeline with sub-agents:

PIPELINE: ContinuousDeployment

TRIGGER: Git push to main branch

Stage 1: CodeValidator
- Run linters (ESLint, Prettier)
- Check types (TypeScript)
- Validate configs
- Security scan
Decision: Pass/Fail

Stage 2: TestRunner
- Unit tests with coverage
- Integration tests
- E2E tests
- Performance tests
Decision: Coverage > 80%

Stage 3: Builder
- Compile TypeScript
- Bundle with Webpack
- Optimize images
- Minify CSS/JS
Output: dist/ folder

Stage 4: ContainerBuilder
- Create Dockerfile
- Build Docker image
- Run security scan
- Push to registry
Output: image:tag

Stage 5: Deployer
- Blue-green deployment
- Update Kubernetes
- Run health checks
- Switch traffic
Output: deployment-url

Stage 6: Validator
- Smoke tests on production
- Monitor for 5 minutes
- Check error rates
- Verify metrics
Decision: Rollback/Success

ROLLBACK PROCEDURE:
If any stage fails:
1. Stop pipeline
2. Send alert
3. Log failure details
4. Trigger rollback if deployed
5. Create incident report"
```

## Context Passing Between Sub-agents

### Explicit Context Passing

```bash
#!/bin/bash
# context-passing.sh

# Create shared context file
echo '{
  "project": "e-commerce",
  "framework": "Next.js",
  "database": "PostgreSQL",
  "testing": "Jest",
  "style": "Tailwind"
}' > context.json

# Pass context to each sub-agent
claude-code "As ComponentBuilder sub-agent:
Read context.json and create React components using:
- Framework: Next.js
- Styling: Tailwind CSS
- Follow project conventions
Output: components/ directory"

claude-code "As APIBuilder sub-agent:
Read context.json and create API endpoints:
- Use Next.js API routes
- Connect to PostgreSQL
- Follow RESTful conventions
Output: pages/api/ directory"

claude-code "As TestBuilder sub-agent:
Read context.json and generate tests:
- Use Jest framework
- Test components and APIs
- Include integration tests
Output: __tests__/ directory"
```

### Context Accumulation Pattern

```bash
#!/bin/bash
# context-accumulation.sh

claude-code "You are ContextOrchestrator. Manage context flow:

INITIALIZE CONTEXT:
{
  'phase': 'analysis',
  'findings': [],
  'decisions': [],
  'artifacts': []
}

PHASE 1: Discovery
Sub-agent: ProjectAnalyzer
Actions:
  - Analyze project structure
  - Identify technologies
  - Detect patterns
Context Update:
  - Add technology stack to context
  - Add file structure map
  - Add dependency graph

PHASE 2: Planning
Sub-agent: ArchitectPlanner
Input: Context from Phase 1
Actions:
  - Design improvements
  - Plan refactoring
  - Identify risks
Context Update:
  - Add improvement plan
  - Add risk assessment
  - Add timeline

PHASE 3: Implementation
Sub-agent: CodeImplementer
Input: Accumulated context
Actions:
  - Execute plan
  - Apply improvements
  - Handle edge cases
Context Update:
  - Add change log
  - Add test results
  - Add metrics

PHASE 4: Review
Sub-agent: QualityReviewer
Input: Full context history
Actions:
  - Review all changes
  - Validate improvements
  - Generate report
Final Output:
  - Complete context history
  - Summary report
  - Lessons learned"
```

## Error Handling in Orchestrated Workflows

### Robust Error Handling Pattern

```bash
#!/bin/bash
# error-handling.sh

claude-code "Implement fault-tolerant orchestration:

WORKFLOW: ResilientPipeline

ERROR HANDLING STRATEGY:
1. Retry with exponential backoff
2. Circuit breaker pattern
3. Graceful degradation
4. Compensating transactions

IMPLEMENTATION:

Stage: DatabaseUpdate
TryBlock:
  - Begin transaction
  - Update user records
  - Update audit log
  - Commit transaction
CatchBlock:
  - Rollback transaction
  - Log error details
  - Increment retry counter
RetryLogic:
  - Max retries: 3
  - Backoff: 1s, 2s, 4s
  - On final failure: trigger compensation
Compensation:
  - Restore from backup
  - Notify admin
  - Create incident ticket

Stage: ExternalAPICall  
TryBlock:
  - Call payment API
  - Process response
  - Update order status
CatchBlock:
  - Check error type
  - If timeout: retry
  - If 4xx: log and skip
  - If 5xx: circuit breaker
CircuitBreaker:
  - After 5 failures: open circuit
  - Wait 30 seconds
  - Try single request
  - If success: close circuit

Stage: FileProcessing
TryBlock:
  - Read input file
  - Transform data
  - Write output file
CatchBlock:
  - If file not found: use default
  - If parse error: quarantine file
  - If disk full: clean temp files
GracefulDegradation:
  - Process what's possible
  - Skip corrupted records
  - Generate partial output
  - Include error summary

MONITORING:
- Log all errors with context
- Track error rates by stage
- Alert on threshold breach
- Generate error analytics"
```

### Saga Pattern for Distributed Transactions

```bash
#!/bin/bash
# saga-pattern.sh

claude-code "Implement Saga pattern for distributed operations:

SAGA: OrderProcessingSaga

PARTICIPANTS:
- InventoryService
- PaymentService
- ShippingService
- NotificationService

FORWARD TRANSACTIONS:

Step 1: ReserveInventory
Service: InventoryService
Action: Reserve items in cart
Compensation: Release reservation

Step 2: ProcessPayment
Service: PaymentService
Action: Charge customer
Compensation: Refund payment

Step 3: CreateShipment
Service: ShippingService
Action: Schedule delivery
Compensation: Cancel shipment

Step 4: SendConfirmation
Service: NotificationService
Action: Email customer
Compensation: Send cancellation

ORCHESTRATION LOGIC:

Happy Path:
1. Start saga with order data
2. Execute each step sequentially
3. Store step results in context
4. On success: complete saga
5. Archive saga log

Failure Handling:
1. On any step failure:
   - Stop forward progress
   - Start compensation
   - Execute compensations in reverse
   - Log compensation results
2. If compensation fails:
   - Retry with backoff
   - Alert support team
   - Create manual intervention task

SAGA COORDINATOR:
- Track saga state
- Manage timeouts
- Handle retries
- Ensure consistency
- Provide observability"
```

## Advanced Orchestration Examples

### Multi-Stage Code Review System

```bash
#!/bin/bash
# code-review-system.sh

claude-code "Build automated code review system:

SYSTEM: IntelligentCodeReview

REVIEW STAGES:

Stage 1: StaticAnalysis
Parallel Sub-agents:
  - LintChecker: ESLint, Prettier
  - TypeChecker: TypeScript strict
  - SecurityScanner: Snyk, OWASP
  - ComplexityAnalyzer: Cyclomatic complexity
Aggregation: Combine all findings

Stage 2: SemanticAnalysis  
Sequential Sub-agents:
  - LogicValidator: Business logic check
  - DataFlowAnalyzer: Track data mutations
  - PerformanceProfiler: Identify bottlenecks
Output: semantic-issues.json

Stage 3: TestValidation
Parallel Sub-agents:
  - CoverageChecker: Min 80% coverage
  - TestQualityAnalyzer: Test effectiveness
  - MutationTester: Test robustness
Decision: Block if coverage < 80%

Stage 4: HumanReadability
Sub-agents:
  - NamingConvention: Variable/function names
  - CommentQuality: Useful comments only
  - StructureAnalyzer: File organization
Score: Readability score 0-100

Stage 5: ImpactAnalysis
Sub-agents:
  - DependencyChecker: Breaking changes
  - APICompatibility: Version compatibility
  - DatabaseImpact: Schema changes
Risk Level: Low/Medium/High

FINAL REVIEW:
- Aggregate all findings
- Generate review score
- Create detailed report
- Suggest improvements
- Auto-fix where possible"
```

### Microservices Deployment Orchestration

```bash
#!/bin/bash
# microservices-deploy.sh

claude-code "Orchestrate microservices deployment:

DEPLOYMENT: MicroservicesRollout

SERVICES:
- UserService (Node.js)
- OrderService (Java)
- PaymentService (Go)
- NotificationService (Python)

ORCHESTRATION:

Phase 1: Preparation
Parallel for each service:
  - Run tests
  - Build Docker image
  - Push to registry
  - Generate manifest
Checkpoint: All images ready

Phase 2: Database Migrations
Sequential by dependency:
  1. UserService schema
  2. OrderService schema (depends on User)
  3. PaymentService schema
  4. NotificationService schema
Checkpoint: Migrations complete

Phase 3: Canary Deployment
For each service:
  - Deploy 10% traffic
  - Monitor for 5 minutes
  - Check error rates
  - If healthy: proceed
  - If unhealthy: rollback
Progressive: 10% -> 25% -> 50% -> 100%

Phase 4: Health Validation
Parallel checks:
  - API endpoint health
  - Database connections
  - Message queue status
  - Cache connectivity
Decision: All green -> proceed

Phase 5: Traffic Switching
Sequential:
  1. Update load balancer
  2. Drain old instances
  3. Scale new instances
  4. Update DNS
Verification: End-to-end tests

Phase 6: Cleanup
- Remove old containers
- Clean up unused images
- Update documentation
- Send deployment report

ROLLBACK STRATEGY:
- Instant rollback trigger
- Restore previous version
- Revert database if needed
- Alert team
- Post-mortem report"
```

## Practice Exercises

### Exercise 1: Build a Database Migration Orchestra
Create an orchestration system that manages complex database migrations across multiple databases with proper rollback capabilities.

### Exercise 2: Design a Multi-Region Deployment Pipeline  
Build a pipeline that deploys applications across multiple cloud regions with health checks and traffic management.

### Exercise 3: Implement a Data ETL Orchestra
Create an orchestration system for Extract, Transform, Load operations with error recovery and data validation.

## Key Takeaways

1. **Orchestration enables complex workflows** through coordinated sub-agents
2. **Parallel execution** dramatically improves performance
3. **Context passing** is crucial for sub-agent communication
4. **Error handling** must be comprehensive and graceful
5. **Pipelines** provide structure and predictability
6. **Monitoring and observability** are essential for production systems

## Next Steps

Day 2 Block 4 will explore advanced patterns including recursive sub-agents, dynamic creation, and complex decision trees.