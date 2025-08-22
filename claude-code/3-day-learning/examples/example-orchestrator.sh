#!/bin/bash
# example-orchestrator.sh - Main workflow coordinator
# This script demonstrates orchestrating multiple sub-agents
# to accomplish complex development workflows

# Function to display usage
show_usage() {
    echo "Usage: $0 [OPTIONS] WORKFLOW"
    echo ""
    echo "Workflows:"
    echo "  full-stack       Build complete full-stack application"
    echo "  microservices    Create microservices architecture"
    echo "  migration        Migrate legacy code to modern stack"
    echo "  optimization     Optimize existing codebase"
    echo "  testing          Generate comprehensive test suite"
    echo ""
    echo "Options:"
    echo "  -p, --project NAME    Project name"
    echo "  -t, --tech STACK      Technology stack (node, python, go)"
    echo "  -d, --database DB     Database (postgres, mongodb, mysql)"
    echo "  -v, --verbose         Enable verbose output"
    echo "  -n, --dry-run         Perform dry run without changes"
    echo "  -h, --help            Show this help message"
}

# Default values
WORKFLOW=""
PROJECT_NAME="my-project"
TECH_STACK="node"
DATABASE="postgres"
VERBOSE=false
DRY_RUN=false

# Parse positional argument (workflow)
if [ $# -eq 0 ]; then
    show_usage
    exit 1
fi

# Get the last argument as workflow
for arg in "$@"; do
    WORKFLOW="$arg"
done

# Parse command line options
while [[ $# -gt 1 ]]; do
    case $1 in
        -p|--project)
            PROJECT_NAME="$2"
            shift 2
            ;;
        -t|--tech)
            TECH_STACK="$2"
            shift 2
            ;;
        -d|--database)
            DATABASE="$2"
            shift 2
            ;;
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        -n|--dry-run)
            DRY_RUN=true
            shift
            ;;
        -h|--help)
            show_usage
            exit 0
            ;;
        *)
            shift
            ;;
    esac
done

# Orchestrator Sub-agent
run_orchestrator() {
    claude-code "You are the Orchestrator sub-agent. Coordinate the $WORKFLOW workflow:

PROJECT CONFIGURATION:
- Workflow: $WORKFLOW
- Project Name: $PROJECT_NAME
- Technology Stack: $TECH_STACK
- Database: $DATABASE
- Dry Run: $DRY_RUN
- Verbose: $VERBOSE

$(case $WORKFLOW in
    full-stack)
        echo "FULL-STACK APPLICATION WORKFLOW:

PHASE 1: PROJECT INITIALIZATION
Sub-agent: ProjectInitializer
Tasks:
1. Create project structure
2. Initialize git repository
3. Setup package.json / requirements.txt
4. Configure environment files
5. Create README.md
Output: project-structure.json

PHASE 2: BACKEND DEVELOPMENT
Parallel Sub-agents:

Agent 1: DatabaseArchitect
- Design database schema
- Create migration files
- Setup database connections
- Generate seed data
Output: database-schema.sql

Agent 2: APIBuilder
- Generate REST endpoints
- Implement controllers
- Create service layer
- Setup middleware
Output: api-endpoints.json

Agent 3: AuthenticationBuilder
- Implement user authentication
- Setup JWT/OAuth
- Create authorization middleware
- Generate auth routes
Output: auth-config.json

Synchronization Point: Wait for all backend agents

PHASE 3: FRONTEND DEVELOPMENT
Sub-agent: FrontendBuilder
Tasks:
1. Create React/Vue/Angular app
2. Setup routing
3. Build components:
   - Authentication forms
   - Dashboard
   - Data tables
   - Forms
4. Integrate with backend API
5. Setup state management
Output: frontend-structure.json

PHASE 4: INTEGRATION
Sub-agent: IntegrationSpecialist
Tasks:
1. Connect frontend to backend
2. Setup proxy configuration
3. Implement error handling
4. Add loading states
5. Configure CORS
Output: integration-complete.flag

PHASE 5: TESTING
Parallel Sub-agents:

Agent 1: UnitTestGenerator
- Generate unit tests for backend
- Generate unit tests for frontend
- Achieve 80% coverage
Output: unit-test-report.json

Agent 2: IntegrationTestBuilder
- Create API integration tests
- Test database operations
- Test authentication flow
Output: integration-test-report.json

Agent 3: E2ETestCreator
- Generate end-to-end tests
- Test critical user paths
- Test cross-browser compatibility
Output: e2e-test-report.json

PHASE 6: OPTIMIZATION
Sub-agent: PerformanceOptimizer
Tasks:
1. Optimize database queries
2. Implement caching
3. Minify and bundle assets
4. Setup lazy loading
5. Configure CDN
Output: optimization-report.md

PHASE 7: DOCUMENTATION
Sub-agent: DocumentationGenerator
Tasks:
1. Generate API documentation
2. Create user guide
3. Write developer documentation
4. Generate architecture diagrams
5. Create deployment guide
Output: docs/

PHASE 8: DEPLOYMENT PREPARATION
Sub-agent: DevOpsEngineer
Tasks:
1. Create Dockerfile
2. Setup docker-compose
3. Configure CI/CD pipeline
4. Create deployment scripts
5. Setup monitoring
Output: deployment-ready.flag"
        ;;
    
    microservices)
        echo "MICROSERVICES ARCHITECTURE WORKFLOW:

PHASE 1: ARCHITECTURE DESIGN
Sub-agent: ArchitectureDesigner
Tasks:
1. Identify service boundaries
2. Design service communication
3. Plan data management
4. Create architecture diagram
Output: architecture-design.md

PHASE 2: SERVICE GENERATION
Parallel Sub-agents (one per service):

Services to create:
- API Gateway Service
- Authentication Service  
- User Service
- Product Service
- Order Service
- Notification Service
- Payment Service

For each service:
1. Create service structure
2. Implement business logic
3. Setup database/datastore
4. Create API endpoints
5. Add service discovery
6. Implement health checks

PHASE 3: INTER-SERVICE COMMUNICATION
Sub-agent: CommunicationBuilder
Tasks:
1. Setup message broker (RabbitMQ/Kafka)
2. Implement event publishing
3. Create event subscribers
4. Setup service mesh
5. Configure load balancing
Output: communication-layer.json

PHASE 4: CONTAINERIZATION
Sub-agent: ContainerizationExpert
Tasks:
1. Create Dockerfile for each service
2. Optimize image sizes
3. Setup docker-compose for local development
4. Create Kubernetes manifests
5. Configure Helm charts
Output: k8s/

PHASE 5: API GATEWAY
Sub-agent: GatewayBuilder
Tasks:
1. Setup Kong/Express Gateway
2. Configure routing rules
3. Implement rate limiting
4. Add authentication
5. Setup request/response transformation
Output: gateway-config.yaml

PHASE 6: MONITORING & LOGGING
Sub-agent: ObservabilityEngineer
Tasks:
1. Setup Prometheus metrics
2. Configure Grafana dashboards
3. Implement distributed tracing
4. Setup ELK stack
5. Create alerting rules
Output: monitoring-setup.md"
        ;;
    
    migration)
        echo "LEGACY MIGRATION WORKFLOW:

PHASE 1: CODEBASE ANALYSIS
Sub-agent: LegacyAnalyzer
Tasks:
1. Scan existing codebase
2. Identify technologies used
3. Map dependencies
4. Find deprecated patterns
5. Assess migration complexity
Output: analysis-report.md

PHASE 2: MIGRATION PLANNING
Sub-agent: MigrationPlanner
Tasks:
1. Create migration roadmap
2. Identify breaking changes
3. Plan phased approach
4. Estimate timeline
5. Define success criteria
Output: migration-plan.md

PHASE 3: DEPENDENCY MODERNIZATION
Sub-agent: DependencyModernizer
Tasks:
1. Update package versions
2. Replace deprecated packages
3. Migrate to modern alternatives
4. Update configuration files
5. Fix compatibility issues
Output: dependencies-updated.json

PHASE 4: CODE TRANSFORMATION
Parallel Sub-agents:

Agent 1: SyntaxModernizer
- Convert old syntax to modern
- Update language features
- Apply new patterns
Output: syntax-modernized.flag

Agent 2: ArchitectureRefactorer
- Restructure code organization
- Implement design patterns
- Separate concerns
Output: architecture-improved.flag

Agent 3: APIModernizer
- Update API patterns
- Implement RESTful principles
- Add GraphQL if needed
Output: api-modernized.flag

PHASE 5: DATABASE MIGRATION
Sub-agent: DatabaseMigrator
Tasks:
1. Analyze current schema
2. Design new schema
3. Create migration scripts
4. Implement data transformation
5. Validate data integrity
Output: database-migrated.flag

PHASE 6: TESTING MIGRATION
Sub-agent: MigrationTester
Tasks:
1. Create comparison tests
2. Verify functionality parity
3. Performance benchmarking
4. Regression testing
5. User acceptance testing
Output: migration-test-report.md

PHASE 7: GRADUAL ROLLOUT
Sub-agent: RolloutManager
Tasks:
1. Setup feature flags
2. Implement canary deployment
3. Monitor metrics
4. Collect feedback
5. Plan cutover
Output: rollout-status.json"
        ;;
    
    optimization)
        echo "CODEBASE OPTIMIZATION WORKFLOW:

PHASE 1: PERFORMANCE PROFILING
Sub-agent: PerformanceProfiler
Tasks:
1. Run performance benchmarks
2. Identify bottlenecks
3. Profile memory usage
4. Analyze database queries
5. Check network requests
Output: performance-baseline.json

PHASE 2: CODE OPTIMIZATION
Parallel Sub-agents:

Agent 1: AlgorithmOptimizer
- Identify inefficient algorithms
- Implement better data structures
- Optimize loops and iterations
- Add memoization
Output: algorithms-optimized.flag

Agent 2: DatabaseOptimizer
- Optimize slow queries
- Add appropriate indexes
- Implement query caching
- Denormalize where needed
Output: database-optimized.flag

Agent 3: AssetOptimizer
- Minify JavaScript/CSS
- Optimize images
- Implement lazy loading
- Setup code splitting
Output: assets-optimized.flag

PHASE 3: CACHING IMPLEMENTATION
Sub-agent: CachingExpert
Tasks:
1. Implement Redis caching
2. Add browser caching headers
3. Setup CDN caching
4. Implement service worker cache
5. Add database query cache
Output: caching-implemented.flag

PHASE 4: ARCHITECTURE IMPROVEMENTS
Sub-agent: ArchitectureOptimizer
Tasks:
1. Implement microservices where beneficial
2. Add message queues for async operations
3. Implement worker processes
4. Setup load balancing
5. Add horizontal scaling capability
Output: architecture-optimized.flag

PHASE 5: MONITORING SETUP
Sub-agent: MonitoringSpecialist
Tasks:
1. Setup APM (Application Performance Monitoring)
2. Create performance dashboards
3. Implement alerting
4. Add custom metrics
5. Setup error tracking
Output: monitoring-configured.flag

PHASE 6: VALIDATION
Sub-agent: OptimizationValidator
Tasks:
1. Run performance tests
2. Compare with baseline
3. Verify functionality intact
4. Check resource usage
5. Generate improvement report
Output: optimization-complete-report.md"
        ;;
    
    testing)
        echo "COMPREHENSIVE TESTING WORKFLOW:

PHASE 1: TEST PLANNING
Sub-agent: TestPlanner
Tasks:
1. Analyze codebase structure
2. Identify test requirements
3. Plan test categories
4. Define coverage goals
5. Create test strategy
Output: test-plan.md

PHASE 2: UNIT TEST GENERATION
Sub-agent: UnitTestGenerator
Tasks:
1. Generate tests for all functions
2. Test edge cases
3. Test error handling
4. Mock dependencies
5. Achieve 90% coverage
Output: unit-tests/

PHASE 3: INTEGRATION TESTING
Sub-agent: IntegrationTestBuilder
Tasks:
1. Test API endpoints
2. Test database operations
3. Test service interactions
4. Test authentication flows
5. Test third-party integrations
Output: integration-tests/

PHASE 4: E2E TESTING
Sub-agent: E2ETestCreator
Tasks:
1. Create user journey tests
2. Test critical paths
3. Cross-browser testing
4. Mobile responsiveness tests
5. Performance testing
Output: e2e-tests/

PHASE 5: SPECIALIZED TESTING
Parallel Sub-agents:

Agent 1: SecurityTester
- Run security scans
- Test for vulnerabilities
- Check authentication
- Test authorization
- Validate input sanitization
Output: security-test-report.md

Agent 2: PerformanceTester
- Load testing
- Stress testing
- Spike testing
- Endurance testing
- Scalability testing
Output: performance-test-report.md

Agent 3: AccessibilityTester
- WCAG compliance testing
- Screen reader testing
- Keyboard navigation testing
- Color contrast testing
- ARIA implementation testing
Output: accessibility-test-report.md

PHASE 6: TEST AUTOMATION
Sub-agent: AutomationEngineer
Tasks:
1. Setup CI/CD test pipeline
2. Configure test environments
3. Implement test data management
4. Setup parallel test execution
5. Configure test reporting
Output: test-automation-setup.md

PHASE 7: TEST REPORTING
Sub-agent: TestReporter
Tasks:
1. Generate coverage reports
2. Create test dashboards
3. Document test results
4. Identify gaps
5. Provide recommendations
Output: test-summary-report.md"
        ;;
    
    *)
        echo "ERROR: Unknown workflow '$WORKFLOW'"
        exit 1
        ;;
esac)

ORCHESTRATION CONTROL:

1. EXECUTION MODE:
$(if [ "$DRY_RUN" = true ]; then
    echo "   - DRY RUN: Simulate all operations without making changes
   - Generate preview of all changes
   - Create dry-run-report.md"
else
    echo "   - LIVE MODE: Execute all operations
   - Make actual changes to codebase
   - Create backups before modifications"
fi)

2. PROGRESS TRACKING:
$(if [ "$VERBOSE" = true ]; then
    echo "   - Show detailed progress for each sub-agent
   - Log all operations to orchestrator.log
   - Display real-time status updates
   - Include timing information"
else
    echo "   - Show phase-level progress only
   - Log errors and warnings
   - Display summary information"
fi)

3. ERROR HANDLING:
   - If any critical sub-agent fails, stop workflow
   - Log all errors to error.log
   - Attempt automatic recovery where possible
   - Provide rollback instructions

4. COORDINATION:
   - Manage dependencies between phases
   - Handle parallel agent synchronization
   - Pass context between agents
   - Aggregate results from all agents

5. FINAL OUTPUT:
   - Generate orchestration-complete.md with:
     * Workflow summary
     * Phases completed
     * Time taken per phase
     * Total time
     * Success/failure status
     * Next steps
   - Create project-manifest.json with all artifacts
   - Generate run-instructions.md

SUCCESS CRITERIA:
- All phases completed successfully
- No critical errors
- All tests passing
- Documentation generated
- Project ready for use"
}

# Main execution
echo "========================================"
echo "    ORCHESTRATOR SUB-AGENT"
echo "========================================"
echo "Workflow: $WORKFLOW"
echo "Project: $PROJECT_NAME"
echo "Technology: $TECH_STACK"
echo "Database: $DATABASE"
[ "$DRY_RUN" = true ] && echo "Mode: DRY RUN"
[ "$VERBOSE" = true ] && echo "Verbose: ENABLED"
echo "========================================"
echo ""

# Confirm before proceeding
if [ "$DRY_RUN" = false ]; then
    read -p "This will create/modify files. Continue? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Aborted."
        exit 1
    fi
fi

echo "Starting orchestration..."
echo ""

# Run the orchestrator
run_orchestrator

echo ""
echo "========================================"
echo "Orchestration complete!"
echo "Check orchestration-complete.md for full report."
echo "Project location: ./$PROJECT_NAME/"
echo "========================================"