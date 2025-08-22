# Day 2 - Block 4: Advanced Sub-agent Patterns
## Learning Objectives
- Master recursive sub-agent patterns
- Implement conditional sub-agent execution
- Create dynamic sub-agent generation
- Build reusable sub-agent templates
- Design complex workflow systems

## Recursive Sub-agent Patterns

### Understanding Recursion in Sub-agents
Recursive sub-agents can spawn instances of themselves or other sub-agents to handle nested or hierarchical tasks.

### Basic Recursive Pattern

```bash
#!/bin/bash
# recursive-basic.sh

claude-code "You are RecursiveProcessor sub-agent.

TASK: Process nested directory structure

RECURSIVE LOGIC:
ProcessDirectory(path):
  1. List all items in path
  2. For each item:
     - If file: process file
     - If directory: 
       * Spawn new RecursiveProcessor
       * ProcessDirectory(item_path)
  3. Aggregate results from sub-processes
  4. Return processed data

START: ProcessDirectory('./')

FILE PROCESSING:
- Count lines of code
- Extract TODOs
- Find complexity issues
- Generate metrics

TERMINATION:
- Stop when no more subdirectories
- Maximum depth: 10 levels
- Skip node_modules, .git

OUTPUT: tree-metrics.json with nested structure"
```

### Advanced Recursive Tree Processor

```bash
#!/bin/bash
# recursive-tree.sh

claude-code "Implement recursive dependency resolver:

PROBLEM: Resolve all package dependencies recursively

ALGORITHM:
ResolveDependencies(package):
  cache = {}
  
  function resolve(pkg, depth):
    if pkg in cache:
      return cache[pkg]
    
    if depth > MAX_DEPTH:
      throw 'Circular dependency detected'
    
    dependencies = []
    pkg_json = read(pkg/package.json)
    
    for dep in pkg_json.dependencies:
      # Recursive call through sub-agent
      sub_result = spawn_subagent(
        'Resolve dependency: ' + dep,
        resolve(dep, depth + 1)
      )
      dependencies.append(sub_result)
    
    cache[pkg] = {
      name: pkg,
      version: pkg_json.version,
      dependencies: dependencies
    }
    
    return cache[pkg]
  
  return resolve(package, 0)

FEATURES:
- Detect circular dependencies
- Cache resolved packages
- Handle version conflicts
- Generate dependency tree
- Calculate total size
- Identify security issues

OUTPUT:
- dependency-tree.json
- security-report.md
- size-analysis.txt"
```

### Recursive Code Refactoring

```bash
#!/bin/bash
# recursive-refactor.sh

claude-code "Create recursive refactoring system:

PATTERN: Recursive AST Transformer

MISSION: Refactor nested code structures

RefactorNode(node):
  switch node.type:
    case 'Function':
      if node.lines > 20:
        # Extract helper functions
        helpers = extractHelpers(node)
        for helper in helpers:
          RefactorNode(helper)  # Recursive
      
    case 'Class':
      for method in node.methods:
        RefactorNode(method)  # Recursive
      if node.lines > 200:
        # Split into multiple classes
        splitClasses(node)
    
    case 'Conditional':
      if node.depth > 3:
        # Flatten nested conditions
        flattened = flattenConditions(node)
        RefactorNode(flattened)  # Recursive
    
    case 'Loop':
      if hasNestedLoops(node):
        # Extract to separate function
        extracted = extractLoop(node)
        RefactorNode(extracted)  # Recursive

RECURSION CONTROL:
- Track recursion depth
- Set maximum iterations
- Detect infinite loops
- Cache processed nodes
- Skip already optimized

EXAMPLE TRANSFORMATION:
Before:
  function processData(data) {
    if (data) {
      if (data.items) {
        for (let item of data.items) {
          if (item.valid) {
            // 50 lines of code
          }
        }
      }
    }
  }

After:
  function processData(data) {
    if (!isValidData(data)) return;
    
    data.items
      .filter(isValidItem)
      .forEach(processItem);
  }
  
  function isValidData(data) { ... }
  function isValidItem(item) { ... }
  function processItem(item) { ... }"
```

## Conditional Sub-agent Execution

### Basic Conditional Pattern

```bash
#!/bin/bash
# conditional-basic.sh

claude-code "Implement conditional sub-agent routing:

ANALYZE PROJECT:
- Detect project type
- Check configuration files
- Identify frameworks

CONDITIONAL ROUTING:

if (projectType === 'react'):
  spawn_subagent('ReactOptimizer', {
    tasks: [
      'Setup React best practices',
      'Configure webpack',
      'Add React testing library',
      'Setup component structure'
    ]
  })
  
elif (projectType === 'vue'):
  spawn_subagent('VueOptimizer', {
    tasks: [
      'Setup Vue 3 composition API',
      'Configure Vite',
      'Add Pinia store',
      'Setup component testing'
    ]
  })
  
elif (projectType === 'angular'):
  spawn_subagent('AngularOptimizer', {
    tasks: [
      'Setup Angular modules',
      'Configure services',
      'Add RxJS patterns',
      'Setup Karma/Jasmine'
    ]
  })
  
else:
  spawn_subagent('GenericOptimizer', {
    tasks: [
      'Setup basic structure',
      'Add linting',
      'Configure testing',
      'Add documentation'
    ]
  })

DYNAMIC CONDITIONS:
- Check for TypeScript -> Add type checking
- Check for Docker -> Add containerization
- Check for CI/CD -> Add pipeline config
- Check for database -> Add migrations"
```

### Complex Decision Tree

```bash
#!/bin/bash
# decision-tree.sh

claude-code "Build intelligent decision tree system:

DECISION TREE: Automated Bug Fixer

ROOT DECISION: Analyze error type

Branch 1: SYNTAX_ERROR
  Sub-decision: Language?
    - JavaScript: 
      * Check for missing semicolons
      * Fix unclosed brackets
      * Correct typos in keywords
    - Python:
      * Fix indentation
      * Correct syntax errors
      * Add missing colons
    - TypeScript:
      * Fix type errors
      * Add missing types
      * Resolve conflicts

Branch 2: RUNTIME_ERROR  
  Sub-decision: Error category?
    - NullPointer:
      * Add null checks
      * Initialize variables
      * Handle undefined
    - TypeMismatch:
      * Convert types
      * Add type guards
      * Fix coercion
    - AsyncError:
      * Add await keywords
      * Handle promises
      * Fix race conditions

Branch 3: LOGIC_ERROR
  Sub-decision: Logic type?
    - OffByOne:
      * Fix loop boundaries
      * Adjust array indices
      * Correct ranges
    - InfiniteLoop:
      * Add termination condition
      * Fix increment/decrement
      * Add timeout
    - WrongAlgorithm:
      * Identify correct algorithm
      * Reimplement logic
      * Add test cases

Branch 4: PERFORMANCE_ISSUE
  Sub-decision: Bottleneck?
    - Database:
      * Optimize queries
      * Add indexes
      * Implement caching
    - Algorithm:
      * Use better data structure
      * Reduce complexity
      * Add memoization
    - Memory:
      * Fix memory leaks
      * Reduce allocations
      * Implement pooling

EXECUTION:
- Traverse tree based on conditions
- Execute appropriate sub-agent
- Collect and merge results
- Validate fixes
- Generate report"
```

### Multi-Criteria Conditional Routing

```bash
#!/bin/bash
# multi-criteria.sh

claude-code "Implement multi-criteria routing system:

ROUTING MATRIX:

Criteria Analysis:
1. Project Size: small/medium/large
2. Team Size: solo/small/enterprise
3. Complexity: simple/moderate/complex
4. Timeline: urgent/normal/relaxed
5. Quality: MVP/production/critical

ROUTING LOGIC:

function routeToSubAgent(criteria):
  score = calculateScore(criteria)
  
  # High complexity + urgent timeline
  if (criteria.complexity === 'complex' && 
      criteria.timeline === 'urgent'):
    return spawn_subagent('CrisisManager', {
      mode: 'rapid-delivery',
      parallel_workers: 10,
      skip_nice_to_have: true
    })
  
  # Enterprise + critical quality
  if (criteria.teamSize === 'enterprise' && 
      criteria.quality === 'critical'):
    return spawn_subagent('EnterpriseBuilder', {
      mode: 'high-reliability',
      include_compliance: true,
      extensive_testing: true,
      documentation_level: 'comprehensive'
    })
  
  # Solo + MVP
  if (criteria.teamSize === 'solo' && 
      criteria.quality === 'MVP'):
    return spawn_subagent('RapidPrototyper', {
      mode: 'fast-iteration',
      use_templates: true,
      minimal_setup: true
    })
  
  # Default routing based on score
  if (score > 80):
    return spawn_subagent('PremiumBuilder')
  elif (score > 50):
    return spawn_subagent('StandardBuilder')
  else:
    return spawn_subagent('BasicBuilder')

ADAPTIVE ROUTING:
- Learn from past decisions
- Adjust thresholds based on outcomes
- Collect metrics for optimization
- Enable A/B testing of routes"
```

## Dynamic Sub-agent Creation

### Runtime Sub-agent Generation

```bash
#!/bin/bash
# dynamic-generation.sh

claude-code "Create dynamic sub-agent generator:

GENERATOR: DynamicAgentFactory

TEMPLATE ENGINE:
function createSubAgent(specification):
  template = '''
  You are {{agentName}} sub-agent.
  
  CAPABILITIES:
  {{#each capabilities}}
  - {{this}}
  {{/each}}
  
  TOOLS:
  {{#each tools}}
  - {{this}}
  {{/each}}
  
  WORKFLOW:
  {{#each workflow}}
  {{@index}}. {{this}}
  {{/each}}
  
  CONSTRAINTS:
  {{#each constraints}}
  - {{this}}
  {{/each}}
  '''
  
  return render(template, specification)

EXAMPLE USAGE:

# Dynamically create a migration agent
spec = {
  agentName: 'MySQL2PostgresMigrator',
  capabilities: [
    'Read MySQL schema',
    'Convert data types',
    'Transform SQL syntax',
    'Handle sequences'
  ],
  tools: [
    'mysqldump',
    'pg_dump',
    'sed',
    'awk'
  ],
  workflow: [
    'Export MySQL schema',
    'Convert to PostgreSQL format',
    'Create PostgreSQL database',
    'Import transformed schema',
    'Migrate data in batches',
    'Verify data integrity'
  ],
  constraints: [
    'Maintain data consistency',
    'Zero downtime migration',
    'Rollback capability'
  ]
}

agent = createSubAgent(spec)
execute(agent)

DYNAMIC FEATURES:
- Generate based on project analysis
- Adapt to user preferences
- Learn from successful patterns
- Combine capabilities dynamically"
```

### Adaptive Sub-agent Evolution

```bash
#!/bin/bash
# adaptive-evolution.sh

claude-code "Build self-improving sub-agent system:

SYSTEM: EvolvingAgentFramework

GENETIC ALGORITHM FOR AGENTS:

Generation 1: Initial Population
- Create 10 variant sub-agents
- Each with different parameters:
  * Aggressiveness level
  * Error tolerance
  * Optimization focus
  * Tool preferences

Fitness Evaluation:
- Execute each agent on test tasks
- Measure:
  * Speed of completion
  * Code quality score
  * Bug count
  * Test coverage
  * User satisfaction

Selection:
- Keep top 3 performers
- Eliminate bottom 5
- Random selection of 2

Crossover:
- Combine traits of successful agents
- Mix parameters and strategies
- Create hybrid approaches

Mutation:
- Random parameter changes
- Add new capabilities
- Modify workflows
- Adjust constraints

Generation N: Evolved Agents
- Repeat for N generations
- Track improvement metrics
- Identify optimal configurations

EXAMPLE EVOLUTION:

Gen 1: BasicRefactorer
- Conservative changes
- High safety checks
- Slow but reliable

Gen 5: OptimizedRefactorer  
- Learned risky patterns are safe
- Reduced redundant checks
- 3x faster

Gen 10: IntelligentRefactorer
- Predicts likely issues
- Parallel processing
- Context-aware decisions
- 10x faster, same quality

PERSISTENCE:
- Save successful agent templates
- Create agent library
- Share across projects
- Continuous improvement"
```

## Sub-agent Templates and Reusability

### Template Library System

```bash
#!/bin/bash
# template-library.sh

claude-code "Create reusable sub-agent template library:

TEMPLATE REGISTRY:

# Template 1: CRUD Generator
register_template('CRUDGenerator', {
  description: 'Generate CRUD operations for any entity',
  parameters: [
    'entityName',
    'fields',
    'database',
    'framework'
  ],
  workflow: [
    'Generate model/schema',
    'Create controllers',
    'Build service layer',
    'Add validation',
    'Generate tests',
    'Create documentation'
  ],
  outputs: [
    '{{entityName}}.model.js',
    '{{entityName}}.controller.js',
    '{{entityName}}.service.js',
    '{{entityName}}.test.js'
  ]
})

# Template 2: API Client Generator
register_template('APIClientGenerator', {
  description: 'Generate typed API clients',
  parameters: [
    'apiSpec',
    'language',
    'authType'
  ],
  workflow: [
    'Parse OpenAPI spec',
    'Generate type definitions',
    'Create client methods',
    'Add authentication',
    'Include retry logic',
    'Generate usage docs'
  ]
})

# Template 3: Migration Orchestrator
register_template('MigrationOrchestrator', {
  description: 'Orchestrate complex migrations',
  parameters: [
    'sourceVersion',
    'targetVersion',
    'strategy'
  ],
  workflow: [
    'Analyze differences',
    'Create migration plan',
    'Backup current state',
    'Execute migrations',
    'Validate results',
    'Handle rollback'
  ]
})

USAGE:
# Instantiate from template
agent = instantiate_template('CRUDGenerator', {
  entityName: 'User',
  fields: ['id', 'name', 'email'],
  database: 'PostgreSQL',
  framework: 'Express'
})

execute_agent(agent)

TEMPLATE COMPOSITION:
# Combine multiple templates
workflow = compose_templates([
  'CRUDGenerator',
  'APIClientGenerator',
  'TestSuiteGenerator',
  'DocumentationBuilder'
])

execute_workflow(workflow, context)"
```

### Parameterized Sub-agent Factory

```bash
#!/bin/bash
# parameterized-factory.sh

claude-code "Build parameterized sub-agent factory:

FACTORY: ConfigurableAgentFactory

BASE AGENT CLASS:
class BaseSubAgent:
  constructor(config):
    this.name = config.name
    this.capabilities = config.capabilities
    this.constraints = config.constraints
    this.tools = config.tools
    
  execute(task):
    this.validate(task)
    this.setup()
    result = this.process(task)
    this.cleanup()
    return result

SPECIALIZED FACTORIES:

# Performance-focused factory
createPerformanceAgent(params):
  return BaseSubAgent({
    name: 'PerformanceOptimizer',
    capabilities: [
      'Profile code execution',
      'Identify bottlenecks',
      'Apply optimizations',
      'Measure improvements'
    ],
    constraints: [
      'Maintain functionality',
      'Preserve readability',
      'Document changes'
    ],
    tools: [
      params.profiler || 'default-profiler',
      params.benchmark || 'default-benchmark',
      params.optimizer || 'default-optimizer'
    ],
    config: {
      targetMetric: params.metric || 'speed',
      threshold: params.threshold || 20,
      maxIterations: params.iterations || 5
    }
  })

# Security-focused factory  
createSecurityAgent(params):
  return BaseSubAgent({
    name: 'SecurityAuditor',
    capabilities: [
      'Scan for vulnerabilities',
      'Check dependencies',
      'Review authentication',
      'Test authorization'
    ],
    constraints: [
      'No false positives',
      'Comprehensive coverage',
      'Actionable recommendations'
    ],
    tools: [
      'OWASP scanner',
      'Dependency checker',
      'Static analyzer',
      params.customScanner
    ].filter(Boolean),
    config: {
      severity: params.severity || 'high',
      compliance: params.compliance || 'OWASP',
      autoFix: params.autoFix || false
    }
  })

USAGE EXAMPLES:

# Create custom performance agent
perfAgent = createPerformanceAgent({
  metric: 'memory',
  threshold: 50,
  profiler: 'node-heapdump',
  iterations: 10
})

# Create security agent with compliance
secAgent = createSecurityAgent({
  severity: 'medium',
  compliance: 'PCI-DSS',
  autoFix: true,
  customScanner: 'internal-tool'
})

# Execute agents
perfAgent.execute('Optimize memory usage in src/')
secAgent.execute('Audit entire codebase')"
```

## Complex Workflow Examples

### Multi-Phase Project Generator

```bash
#!/bin/bash
# project-generator.sh

claude-code "Create sophisticated project generator:

PROJECT: FullStackAppGenerator

PHASE 1: Project Analysis
Agents:
  - RequirementsAnalyzer
  - TechStackSelector
  - ArchitectureDesigner
Output: project-blueprint.json

PHASE 2: Backend Generation
Parallel Agents:
  - DatabaseDesigner:
    * Design schema
    * Create migrations
    * Setup seeders
  - APIBuilder:
    * Generate endpoints
    * Add authentication
    * Setup middleware
  - ServiceLayerCreator:
    * Business logic
    * Validation rules
    * Error handling

PHASE 3: Frontend Generation
Conditional Agents:
  if (blueprint.ui === 'React'):
    - ReactAppBuilder
    - ReduxSetup
    - ReactRouterConfig
  elif (blueprint.ui === 'Vue'):
    - VueAppBuilder
    - VuexSetup
    - VueRouterConfig
  else:
    - VanillaJSBuilder

PHASE 4: Integration
Sequential Agents:
  - APIConnector:
    * Connect frontend to backend
    * Setup axios/fetch
    * Add interceptors
  - AuthenticationBridge:
    * Connect auth flow
    * Setup token management
    * Add route guards

PHASE 5: DevOps Setup
Parallel Agents:
  - Dockerizer:
    * Create Dockerfiles
    * Setup docker-compose
    * Add .dockerignore
  - CICDPipeline:
    * GitHub Actions
    * Testing pipeline
    * Deployment config
  - MonitoringSetup:
    * Error tracking
    * Performance monitoring
    * Logging system

PHASE 6: Quality Assurance
Recursive Agents:
  - TestGenerator:
    * Unit tests for each module
    * Integration tests
    * E2E tests
  - DocumentationBuilder:
    * API documentation
    * Component docs
    * Setup guides

PHASE 7: Optimization
Dynamic Agents:
  - PerformanceOptimizer (if needed)
  - SecurityHardener (if needed)
  - AccessibilityChecker (if needed)

ORCHESTRATION:
- Track progress across phases
- Handle inter-phase dependencies
- Rollback on critical failures
- Generate comprehensive report"
```

### Intelligent Codebase Migrator

```bash
#!/bin/bash
# intelligent-migrator.sh

claude-code "Build intelligent migration system:

SYSTEM: SmartMigrationOrchestrator

INTELLIGENCE LAYER:
1. Analyze source and target
2. Identify migration paths
3. Calculate risk scores
4. Generate migration plan

MIGRATION STRATEGIES:

Strategy 1: Big Bang
Condition: Small codebase, low risk
Agents:
  - FullMigrator: Complete migration at once
  - Validator: Verify everything works
  - Switcher: Cut over to new system

Strategy 2: Gradual Migration
Condition: Large codebase, medium risk
Agents:
  - ModuleMigrator: Migrate module by module
  - BridgeBuilder: Create compatibility layer
  - ProgressTracker: Monitor migration status

Strategy 3: Parallel Run
Condition: Critical system, high risk
Agents:
  - DualRunner: Run both systems
  - Comparator: Compare outputs
  - Synchronizer: Keep systems in sync
  - CutoverManager: Manage transition

RECURSIVE MIGRATION:
MigrateModule(module):
  dependencies = findDependencies(module)
  
  for dep in dependencies:
    if not migrated(dep):
      MigrateModule(dep)  # Recursive
  
  migrateCode(module)
  updateImports(module)
  runTests(module)
  
  if hasSubmodules(module):
    for submodule in module.submodules:
      MigrateModule(submodule)  # Recursive

CONDITIONAL HANDLERS:
- If tests fail: Rollback and retry
- If performance degrades: Optimize
- If breaking changes: Update consumers
- If data loss risk: Create backups

DYNAMIC ADAPTATION:
- Learn from each migration
- Adjust strategies based on success
- Build pattern library
- Optimize future migrations"
```

## Practice Exercises

### Exercise 1: Build a Recursive Dependency Resolver
Create a sub-agent that recursively resolves and installs all project dependencies, handling version conflicts and circular dependencies.

### Exercise 2: Design a Conditional Deployment System
Build a system that chooses different deployment strategies based on multiple criteria like environment, risk level, and time constraints.

### Exercise 3: Create a Self-Evolving Test Generator
Develop a sub-agent system that learns from test failures and evolves better test generation strategies over time.

## Key Takeaways

1. **Recursive patterns** handle hierarchical and nested structures elegantly
2. **Conditional execution** enables intelligent decision-making
3. **Dynamic generation** provides ultimate flexibility
4. **Templates** promote reusability and consistency
5. **Complex workflows** require careful orchestration
6. **Evolution and adaptation** lead to improved performance over time

## Next Steps

Block 5 will explore project automation, including full project generation, migration workflows, and automated refactoring systems.