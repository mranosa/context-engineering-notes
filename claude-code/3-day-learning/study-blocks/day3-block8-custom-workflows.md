# Day 3 - Block 8: Custom Workflows and Domain-Specific Sub-agents
## Learning Objectives
- Create reusable workflow templates
- Build industry-specific sub-agents
- Master domain-driven sub-agent design
- Integrate with external tools
- Design custom command systems

## Reusable Workflow Templates

### Workflow Template Engine

```bash
#!/bin/bash
# workflow-templates.sh

claude-code "Build workflow template system:

SYSTEM: WorkflowTemplateEngine

CORE TEMPLATE STRUCTURE:

class WorkflowTemplate {
  constructor(config) {
    this.name = config.name;
    this.description = config.description;
    this.inputs = config.inputs;
    this.outputs = config.outputs;
    this.steps = config.steps;
    this.hooks = config.hooks;
  }
  
  async execute(context) {
    // Pre-execution hook
    if (this.hooks.beforeExecute) {
      await this.hooks.beforeExecute(context);
    }
    
    const results = {};
    
    for (const step of this.steps) {
      try {
        // Execute step with context
        const stepResult = await this.executeStep(step, context, results);
        results[step.id] = stepResult;
        
        // Update context with results
        context = { ...context, ...stepResult };
        
      } catch (error) {
        // Error handling
        if (this.hooks.onError) {
          await this.hooks.onError(error, step, context);
        }
        
        if (step.required) {
          throw error;
        }
      }
    }
    
    // Post-execution hook
    if (this.hooks.afterExecute) {
      await this.hooks.afterExecute(results);
    }
    
    return this.formatOutput(results);
  }
  
  async executeStep(step, context, previousResults) {
    // Resolve dependencies
    const inputs = this.resolveDependencies(step.inputs, previousResults);
    
    // Select appropriate sub-agent
    const agent = this.selectAgent(step.type);
    
    // Execute with retry logic
    return await this.executeWithRetry(
      () => agent.execute(step.task, inputs, context),
      step.retries || 3
    );
  }
}

TEMPLATE LIBRARY:

// Code Review Workflow Template
const codeReviewTemplate = new WorkflowTemplate({
  name: 'CodeReviewWorkflow',
  description: 'Comprehensive code review process',
  
  inputs: {
    repository: { type: 'string', required: true },
    branch: { type: 'string', default: 'main' },
    standards: { type: 'object', default: {} }
  },
  
  outputs: {
    report: { type: 'markdown' },
    score: { type: 'number' },
    issues: { type: 'array' }
  },
  
  steps: [
    {
      id: 'fetch_code',
      type: 'git',
      task: 'Clone repository and checkout branch',
      inputs: ['repository', 'branch']
    },
    {
      id: 'static_analysis',
      type: 'analyzer',
      task: 'Run static code analysis',
      inputs: ['fetch_code.files'],
      parallel: true
    },
    {
      id: 'security_scan',
      type: 'security',
      task: 'Scan for vulnerabilities',
      inputs: ['fetch_code.files'],
      parallel: true
    },
    {
      id: 'test_coverage',
      type: 'tester',
      task: 'Check test coverage',
      inputs: ['fetch_code.files']
    },
    {
      id: 'generate_report',
      type: 'reporter',
      task: 'Generate review report',
      inputs: ['static_analysis', 'security_scan', 'test_coverage']
    }
  ],
  
  hooks: {
    beforeExecute: async (context) => {
      console.log(`Starting code review for ${context.repository}`);
    },
    afterExecute: async (results) => {
      await notifySlack(results.generate_report);
    },
    onError: async (error, step) => {
      await logError(error, step);
    }
  }
});

// Deployment Workflow Template
const deploymentTemplate = new WorkflowTemplate({
  name: 'DeploymentWorkflow',
  description: 'Safe production deployment',
  
  inputs: {
    environment: { type: 'string', enum: ['staging', 'production'] },
    version: { type: 'string', required: true },
    strategy: { type: 'string', default: 'blue-green' }
  },
  
  steps: [
    {
      id: 'pre_checks',
      type: 'validator',
      task: 'Run pre-deployment checks',
      required: true
    },
    {
      id: 'backup',
      type: 'backup',
      task: 'Create backup of current state',
      required: true
    },
    {
      id: 'deploy',
      type: 'deployer',
      task: 'Deploy new version',
      inputs: ['version', 'strategy']
    },
    {
      id: 'health_check',
      type: 'monitor',
      task: 'Verify deployment health',
      retries: 5,
      required: true
    },
    {
      id: 'smoke_tests',
      type: 'tester',
      task: 'Run smoke tests',
      required: true
    },
    {
      id: 'traffic_switch',
      type: 'router',
      task: 'Switch traffic to new version',
      condition: 'health_check.status === \"healthy\"'
    },
    {
      id: 'monitoring',
      type: 'monitor',
      task: 'Monitor for 10 minutes',
      duration: 600000
    }
  ],
  
  rollback: {
    trigger: 'monitoring.errors > threshold',
    steps: [
      { type: 'router', task: 'Switch traffic back' },
      { type: 'restore', task: 'Restore from backup' },
      { type: 'alert', task: 'Send rollback notification' }
    ]
  }
});

TEMPLATE COMPOSITION:

// Compose multiple templates
const fullReleaseWorkflow = composeTemplates([
  codeReviewTemplate,
  buildTemplate,
  testTemplate,
  deploymentTemplate,
  monitoringTemplate
]);

// Override specific steps
const customizedWorkflow = codeReviewTemplate.customize({
  steps: {
    security_scan: {
      tool: 'custom-scanner',
      config: { level: 'paranoid' }
    }
  }
});

// Conditional template selection
function selectWorkflowTemplate(context) {
  if (context.isHotfix) {
    return hotfixTemplate;
  } else if (context.isFeature) {
    return featureTemplate;
  } else {
    return standardTemplate;
  }
}"
```

## Industry-Specific Sub-agents

### FinTech Sub-agents

```bash
#!/bin/bash
# fintech-agents.sh

claude-code "Create FinTech-specific sub-agents:

DOMAIN: Financial Technology

SUB-AGENT 1: ComplianceValidator
Purpose: Ensure regulatory compliance

class ComplianceValidator {
  async validateTransaction(transaction) {
    const checks = [];
    
    // AML (Anti-Money Laundering) checks
    checks.push(await this.checkAML(transaction));
    
    // KYC (Know Your Customer) verification
    checks.push(await this.verifyKYC(transaction.parties));
    
    // GDPR compliance
    checks.push(await this.checkGDPR(transaction.data));
    
    // PCI DSS for card transactions
    if (transaction.type === 'card') {
      checks.push(await this.validatePCIDSS(transaction));
    }
    
    // Sanctions screening
    checks.push(await this.screenSanctions(transaction.parties));
    
    return {
      compliant: checks.every(c => c.passed),
      violations: checks.filter(c => !c.passed),
      reportId: await this.fileComplianceReport(checks)
    };
  }
  
  async checkAML(transaction) {
    // Pattern detection for money laundering
    const patterns = [
      this.checkStructuring(transaction),
      this.checkRapidMovement(transaction),
      this.checkUnusualPatterns(transaction)
    ];
    
    const riskScore = this.calculateRiskScore(patterns);
    
    return {
      passed: riskScore < AML_THRESHOLD,
      score: riskScore,
      flags: patterns.filter(p => p.flagged)
    };
  }
}

SUB-AGENT 2: FraudDetector
Purpose: Real-time fraud detection

class FraudDetector {
  constructor() {
    this.mlModel = loadModel('fraud-detection-v2');
    this.rules = loadRules('fraud-rules.json');
  }
  
  async analyzeTransaction(transaction) {
    // Rule-based checks
    const ruleViolations = await this.checkRules(transaction);
    
    // ML-based anomaly detection
    const anomalyScore = await this.mlModel.predict(transaction);
    
    // Behavioral analysis
    const behaviorScore = await this.analyzeBehavior(
      transaction.userId,
      transaction
    );
    
    // Geolocation verification
    const geoRisk = await this.checkGeolocation(transaction);
    
    // Calculate composite risk score
    const riskScore = this.calculateCompositeRisk({
      rules: ruleViolations,
      anomaly: anomalyScore,
      behavior: behaviorScore,
      geo: geoRisk
    });
    
    return {
      risk: riskScore,
      action: this.determineAction(riskScore),
      reasons: this.explainDecision(riskScore)
    };
  }
  
  determineAction(riskScore) {
    if (riskScore > 0.9) return 'BLOCK';
    if (riskScore > 0.7) return 'REVIEW';
    if (riskScore > 0.5) return '2FA_REQUIRED';
    return 'APPROVE';
  }
}

SUB-AGENT 3: PortfolioOptimizer
Purpose: Investment portfolio optimization

class PortfolioOptimizer {
  async optimizePortfolio(portfolio, constraints) {
    // Modern Portfolio Theory optimization
    const efficientFrontier = await this.calculateEfficientFrontier(
      portfolio.assets
    );
    
    // Risk assessment
    const riskProfile = await this.assessRisk(portfolio);
    
    // Constraint satisfaction
    const feasibleAllocations = this.applyConstraints(
      efficientFrontier,
      constraints
    );
    
    // Tax optimization
    const taxOptimized = await this.optimizeForTax(
      feasibleAllocations,
      portfolio.taxSituation
    );
    
    // Rebalancing recommendations
    const rebalancing = this.calculateRebalancing(
      portfolio.current,
      taxOptimized.target
    );
    
    return {
      currentAllocation: portfolio.current,
      targetAllocation: taxOptimized.target,
      expectedReturn: taxOptimized.return,
      risk: taxOptimized.volatility,
      sharpeRatio: taxOptimized.sharpe,
      rebalancingSteps: rebalancing,
      taxImpact: taxOptimized.taxCost
    };
  }
}"
```

### HealthTech Sub-agents

```bash
#!/bin/bash
# healthtech-agents.sh

claude-code "Create HealthTech-specific sub-agents:

DOMAIN: Healthcare Technology

SUB-AGENT 1: MedicalRecordProcessor
Purpose: Process and analyze medical records

class MedicalRecordProcessor {
  async processRecord(record) {
    // HIPAA compliance check
    await this.ensureHIPAACompliance(record);
    
    // Extract medical entities
    const entities = await this.extractMedicalEntities(record);
    
    // Standardize to FHIR format
    const fhirRecord = await this.convertToFHIR(record, entities);
    
    // Identify diagnoses (ICD-10 codes)
    const diagnoses = await this.identifyDiagnoses(entities);
    
    // Extract medications
    const medications = await this.extractMedications(record);
    
    // Identify procedures (CPT codes)
    const procedures = await this.identifyProcedures(record);
    
    // De-identify PHI for research
    const deidentified = await this.deidentifyPHI(fhirRecord);
    
    return {
      structured: fhirRecord,
      diagnoses: diagnoses,
      medications: medications,
      procedures: procedures,
      deidentified: deidentified
    };
  }
  
  async extractMedicalEntities(text) {
    // Use medical NER model
    const entities = await this.medicalNER.extract(text);
    
    return {
      conditions: entities.filter(e => e.type === 'CONDITION'),
      symptoms: entities.filter(e => e.type === 'SYMPTOM'),
      medications: entities.filter(e => e.type === 'MEDICATION'),
      procedures: entities.filter(e => e.type === 'PROCEDURE'),
      anatomy: entities.filter(e => e.type === 'ANATOMY')
    };
  }
}

SUB-AGENT 2: ClinicalDecisionSupport
Purpose: Provide evidence-based clinical recommendations

class ClinicalDecisionSupport {
  async generateRecommendations(patient, symptoms) {
    // Differential diagnosis
    const differentials = await this.generateDifferentials(symptoms);
    
    // Evidence-based guidelines
    const guidelines = await this.fetchGuidelines(differentials);
    
    // Drug interactions check
    const interactions = await this.checkDrugInteractions(
      patient.medications
    );
    
    // Contraindications
    const contraindications = await this.checkContraindications(
      patient,
      guidelines.recommendedTreatments
    );
    
    // Risk stratification
    const riskScore = await this.calculateRiskScore(patient, symptoms);
    
    return {
      differentialDiagnosis: differentials,
      recommendedTests: guidelines.diagnosticTests,
      treatmentOptions: guidelines.treatments.filter(
        t => !contraindications.includes(t.id)
      ),
      urgency: this.determineUrgency(riskScore),
      drugInteractions: interactions,
      evidenceLinks: guidelines.references
    };
  }
}

SUB-AGENT 3: HealthDataAnalyzer
Purpose: Analyze population health data

class HealthDataAnalyzer {
  async analyzePopulation(data, parameters) {
    // Epidemiological analysis
    const epidemiology = await this.runEpidemiologicalAnalysis(data);
    
    // Disease prevalence
    const prevalence = await this.calculatePrevalence(data);
    
    // Risk factor analysis
    const riskFactors = await this.identifyRiskFactors(data);
    
    // Outcome prediction
    const predictions = await this.predictOutcomes(data);
    
    // Quality metrics (HEDIS, etc.)
    const qualityMetrics = await this.calculateQualityMetrics(data);
    
    // Cost analysis
    const costAnalysis = await this.analyzeCosts(data);
    
    return {
      epidemiology,
      prevalence,
      riskFactors,
      predictions,
      qualityMetrics,
      costAnalysis,
      recommendations: this.generateRecommendations(
        epidemiology,
        riskFactors,
        costAnalysis
      )
    };
  }
}"
```

### E-commerce Sub-agents

```bash
#!/bin/bash
# ecommerce-agents.sh

claude-code "Create E-commerce-specific sub-agents:

DOMAIN: E-commerce

SUB-AGENT 1: PricingOptimizer
Purpose: Dynamic pricing optimization

class PricingOptimizer {
  async optimizePricing(product, market) {
    // Competitive analysis
    const competitors = await this.analyzeCompetitors(product);
    
    // Demand elasticity
    const elasticity = await this.calculateElasticity(
      product.historicalSales
    );
    
    // Inventory levels
    const inventory = await this.getInventoryStatus(product);
    
    // Seasonal factors
    const seasonality = await this.getSeasonalFactors(product);
    
    // Customer segments
    const segments = await this.segmentCustomers(product);
    
    // Calculate optimal prices
    const pricing = {
      base: this.calculateBasePrice(product, competitors, elasticity),
      segments: this.calculateSegmentPrices(segments, elasticity),
      dynamic: this.calculateDynamicPrice(inventory, seasonality),
      promotional: this.suggestPromotions(product, market)
    };
    
    // Profit impact analysis
    const impact = await this.simulateProfitImpact(pricing);
    
    return {
      currentPrice: product.price,
      recommendedPrice: pricing.base,
      segmentedPricing: pricing.segments,
      dynamicPricing: pricing.dynamic,
      promotions: pricing.promotional,
      expectedImpact: impact
    };
  }
}

SUB-AGENT 2: PersonalizationEngine
Purpose: Personalized shopping experience

class PersonalizationEngine {
  async personalizeExperience(userId, context) {
    // User profile analysis
    const profile = await this.buildUserProfile(userId);
    
    // Browsing behavior
    const behavior = await this.analyzeBehavior(userId);
    
    // Purchase history
    const purchases = await this.getPurchaseHistory(userId);
    
    // Collaborative filtering
    const collaborative = await this.collaborativeFiltering(profile);
    
    // Content-based filtering
    const contentBased = await this.contentBasedFiltering(purchases);
    
    // Real-time context
    const contextual = this.applyContext(context);
    
    return {
      recommendations: this.mergeRecommendations(
        collaborative,
        contentBased,
        contextual
      ),
      personalizedSearch: this.personalizeSearch(profile),
      customLayout: this.optimizeLayout(behavior),
      targetedPromotions: this.selectPromotions(profile, purchases),
      nextBestAction: this.predictNextAction(behavior)
    };
  }
}

SUB-AGENT 3: InventoryManager
Purpose: Intelligent inventory management

class InventoryManager {
  async optimizeInventory(products, warehouses) {
    // Demand forecasting
    const forecast = await this.forecastDemand(products);
    
    // Reorder point calculation
    const reorderPoints = this.calculateReorderPoints(forecast);
    
    // Safety stock optimization
    const safetyStock = this.optimizeSafetyStock(products);
    
    // ABC analysis
    const abcClassification = this.performABCAnalysis(products);
    
    // Warehouse allocation
    const allocation = await this.optimizeWarehouseAllocation(
      products,
      warehouses,
      forecast
    );
    
    // Dead stock identification
    const deadStock = this.identifyDeadStock(products);
    
    return {
      forecast,
      reorderPoints,
      safetyStock,
      abcClassification,
      warehouseAllocation: allocation,
      deadStock,
      purchaseOrders: this.generatePurchaseOrders(reorderPoints),
      transferOrders: this.generateTransferOrders(allocation)
    };
  }
}"
```

## Domain-Driven Sub-agent Design

### DDD Principles for Sub-agents

```bash
#!/bin/bash
# domain-driven-design.sh

claude-code "Implement DDD for sub-agents:

FRAMEWORK: DomainDrivenSubAgents

BOUNDED CONTEXTS:

// Define bounded contexts
const boundedContexts = {
  sales: {
    entities: ['Order', 'Customer', 'Product'],
    valueObjects: ['Money', 'Address', 'OrderLine'],
    aggregates: ['Order', 'ShoppingCart'],
    services: ['PricingService', 'DiscountService'],
    events: ['OrderPlaced', 'PaymentReceived']
  },
  
  inventory: {
    entities: ['Product', 'Warehouse', 'StockMovement'],
    valueObjects: ['SKU', 'Location', 'Quantity'],
    aggregates: ['Product', 'Warehouse'],
    services: ['AllocationService', 'ReplenishmentService'],
    events: ['StockDepleted', 'StockReplenished']
  },
  
  shipping: {
    entities: ['Shipment', 'Package', 'Carrier'],
    valueObjects: ['TrackingNumber', 'Dimension', 'Weight'],
    aggregates: ['Shipment'],
    services: ['RoutingService', 'TrackingService'],
    events: ['ShipmentDispatched', 'PackageDelivered']
  }
};

AGGREGATE SUB-AGENTS:

class OrderAggregateAgent {
  constructor() {
    this.invariants = [
      'Order total must equal sum of line items',
      'Cannot ship before payment',
      'Cannot cancel after shipping'
    ];
  }
  
  async processCommand(command) {
    switch(command.type) {
      case 'PlaceOrder':
        return this.placeOrder(command);
      case 'CancelOrder':
        return this.cancelOrder(command);
      case 'ShipOrder':
        return this.shipOrder(command);
    }
  }
  
  async placeOrder(command) {
    // Validate invariants
    this.validateInvariants(command.order);
    
    // Apply business rules
    const order = this.applyBusinessRules(command.order);
    
    // Emit domain events
    await this.emit('OrderPlaced', order);
    
    // Trigger other sub-agents
    await this.triggerPaymentAgent(order);
    await this.triggerInventoryAgent(order);
    
    return order;
  }
  
  validateInvariants(order) {
    // Check all invariants
    for (const invariant of this.invariants) {
      if (!this.checkInvariant(invariant, order)) {
        throw new DomainException(`Invariant violated: ${invariant}`);
      }
    }
  }
}

DOMAIN SERVICE SUB-AGENTS:

class PricingServiceAgent {
  async calculatePrice(order, customer) {
    // Domain logic for pricing
    let price = this.getBasePrice(order);
    
    // Apply customer-specific rules
    if (customer.tier === 'PREMIUM') {
      price = this.applyPremiumDiscount(price);
    }
    
    // Apply volume discounts
    price = this.applyVolumeDiscount(price, order.quantity);
    
    // Apply promotional rules
    price = await this.applyPromotions(price, order);
    
    // Apply tax calculations
    price = this.calculateTax(price, customer.location);
    
    return new Money(price, order.currency);
  }
}

EVENT-DRIVEN SUB-AGENTS:

class EventProcessorAgent {
  constructor() {
    this.handlers = new Map();
    this.registerHandlers();
  }
  
  registerHandlers() {
    this.handlers.set('OrderPlaced', [
      this.reserveInventory,
      this.processPayment,
      this.sendConfirmation
    ]);
    
    this.handlers.set('PaymentReceived', [
      this.updateOrderStatus,
      this.triggerFulfillment,
      this.updateAccounting
    ]);
    
    this.handlers.set('StockDepleted', [
      this.createPurchaseOrder,
      this.notifySupplier,
      this.updateForecast
    ]);
  }
  
  async processEvent(event) {
    const handlers = this.handlers.get(event.type) || [];
    
    // Process handlers in parallel where possible
    const results = await Promise.allSettled(
      handlers.map(handler => handler.call(this, event))
    );
    
    // Handle failures
    const failures = results.filter(r => r.status === 'rejected');
    if (failures.length > 0) {
      await this.handleFailures(event, failures);
    }
    
    return results;
  }
}

UBIQUITOUS LANGUAGE:

const domainDictionary = {
  sales: {
    'place_order': 'Create new customer order',
    'fulfill_order': 'Process order for shipment',
    'invoice': 'Bill for products or services',
    'shopping_cart': 'Temporary order container'
  },
  
  inventory: {
    'stock_keeping_unit': 'Unique product identifier',
    'reorder_point': 'Inventory level triggering replenishment',
    'safety_stock': 'Buffer inventory for demand variability',
    'cycle_count': 'Periodic inventory verification'
  }
};

// Sub-agent uses domain language
class DomainAwareAgent {
  async execute(command) {
    // Translate to domain language
    const domainCommand = this.translateToDomain(command);
    
    // Execute in domain context
    const result = await this.executeDomainLogic(domainCommand);
    
    // Translate back to external representation
    return this.translateFromDomain(result);
  }
}"
```

## External Tool Integration

### Tool Integration Framework

```bash
#!/bin/bash
# tool-integration.sh

claude-code "Integrate external tools with sub-agents:

FRAMEWORK: ToolIntegrationFramework

TOOL ADAPTERS:

// Git Integration
class GitAdapter {
  async clone(repository) {
    return await this.execute(`git clone ${repository}`);
  }
  
  async commit(message) {
    await this.execute('git add .');
    return await this.execute(`git commit -m \"${message}\"`);
  }
  
  async push(branch = 'main') {
    return await this.execute(`git push origin ${branch}`);
  }
  
  async createPR(title, body) {
    return await this.execute(`gh pr create --title \"${title}\" --body \"${body}\"`);
  }
}

// Docker Integration
class DockerAdapter {
  async build(dockerfile, tag) {
    return await this.execute(`docker build -f ${dockerfile} -t ${tag} .`);
  }
  
  async run(image, options = {}) {
    const flags = this.buildFlags(options);
    return await this.execute(`docker run ${flags} ${image}`);
  }
  
  async compose(file, command) {
    return await this.execute(`docker-compose -f ${file} ${command}`);
  }
  
  async push(image, registry) {
    await this.execute(`docker tag ${image} ${registry}/${image}`);
    return await this.execute(`docker push ${registry}/${image}`);
  }
}

// Kubernetes Integration
class KubernetesAdapter {
  async deploy(manifest) {
    return await this.execute(`kubectl apply -f ${manifest}`);
  }
  
  async scale(deployment, replicas) {
    return await this.execute(
      `kubectl scale deployment ${deployment} --replicas=${replicas}`
    );
  }
  
  async rollback(deployment) {
    return await this.execute(`kubectl rollout undo deployment ${deployment}`);
  }
  
  async getStatus(resource) {
    return await this.execute(`kubectl get ${resource} -o json`);
  }
}

// Cloud Provider Integration
class AWSAdapter {
  constructor() {
    this.s3 = new S3Client();
    this.ec2 = new EC2Client();
    this.lambda = new LambdaClient();
  }
  
  async uploadToS3(file, bucket, key) {
    return await this.s3.putObject({
      Bucket: bucket,
      Key: key,
      Body: file
    });
  }
  
  async deployLambda(functionName, zipFile) {
    return await this.lambda.updateFunctionCode({
      FunctionName: functionName,
      ZipFile: zipFile
    });
  }
  
  async createEC2Instance(config) {
    return await this.ec2.runInstances(config);
  }
}

TOOL ORCHESTRATOR:

class ToolOrchestrator {
  constructor() {
    this.tools = {
      git: new GitAdapter(),
      docker: new DockerAdapter(),
      k8s: new KubernetesAdapter(),
      aws: new AWSAdapter()
    };
  }
  
  async executeWorkflow(workflow) {
    const results = {};
    
    for (const step of workflow.steps) {
      const tool = this.tools[step.tool];
      
      if (!tool) {
        throw new Error(`Tool ${step.tool} not found`);
      }
      
      // Execute tool command
      const result = await tool[step.command](...step.args);
      results[step.id] = result;
      
      // Check for errors
      if (result.error && step.required) {
        throw new Error(`Step ${step.id} failed: ${result.error}`);
      }
    }
    
    return results;
  }
}

EXAMPLE WORKFLOW:

const deploymentWorkflow = {
  name: 'Full Deployment',
  steps: [
    {
      id: 'checkout',
      tool: 'git',
      command: 'clone',
      args: ['https://github.com/company/app.git']
    },
    {
      id: 'build',
      tool: 'docker',
      command: 'build',
      args: ['Dockerfile', 'app:latest']
    },
    {
      id: 'test',
      tool: 'docker',
      command: 'run',
      args: ['app:latest', { command: 'npm test' }]
    },
    {
      id: 'push',
      tool: 'docker',
      command: 'push',
      args: ['app:latest', 'registry.company.com']
    },
    {
      id: 'deploy',
      tool: 'k8s',
      command: 'deploy',
      args: ['k8s/deployment.yaml']
    },
    {
      id: 'verify',
      tool: 'k8s',
      command: 'getStatus',
      args: ['deployment/app']
    }
  ]
};

await orchestrator.executeWorkflow(deploymentWorkflow);"
```

## Custom Command Creation

### Command System Framework

```bash
#!/bin/bash
# custom-commands.sh

claude-code "Build custom command system:

SYSTEM: CustomCommandFramework

COMMAND DEFINITION:

class CustomCommand {
  constructor(config) {
    this.name = config.name;
    this.description = config.description;
    this.parameters = config.parameters;
    this.action = config.action;
    this.validators = config.validators || [];
    this.permissions = config.permissions || [];
  }
  
  async execute(args, context) {
    // Validate permissions
    if (!this.checkPermissions(context.user)) {
      throw new PermissionError('Insufficient permissions');
    }
    
    // Validate arguments
    const validated = await this.validate(args);
    
    // Execute action
    const result = await this.action(validated, context);
    
    // Log execution
    await this.logExecution(context.user, args, result);
    
    return result;
  }
  
  async validate(args) {
    // Parameter validation
    for (const param of this.parameters) {
      if (param.required && !args[param.name]) {
        throw new ValidationError(`Missing required parameter: ${param.name}`);
      }
      
      if (param.type && !this.checkType(args[param.name], param.type)) {
        throw new ValidationError(`Invalid type for ${param.name}`);
      }
    }
    
    // Custom validators
    for (const validator of this.validators) {
      await validator(args);
    }
    
    return args;
  }
}

COMMAND REGISTRY:

class CommandRegistry {
  constructor() {
    this.commands = new Map();
    this.aliases = new Map();
    this.registerBuiltinCommands();
  }
  
  register(command) {
    this.commands.set(command.name, command);
    
    // Register aliases
    if (command.aliases) {
      command.aliases.forEach(alias => {
        this.aliases.set(alias, command.name);
      });
    }
  }
  
  async execute(commandString, context) {
    const { command, args } = this.parse(commandString);
    
    // Resolve aliases
    const commandName = this.aliases.get(command) || command;
    
    // Get command
    const cmd = this.commands.get(commandName);
    
    if (!cmd) {
      throw new CommandNotFoundError(`Command '${command}' not found`);
    }
    
    // Execute
    return await cmd.execute(args, context);
  }
  
  parse(commandString) {
    const parts = commandString.split(' ');
    const command = parts[0];
    const args = this.parseArgs(parts.slice(1));
    
    return { command, args };
  }
  
  parseArgs(argArray) {
    const args = {};
    
    for (let i = 0; i < argArray.length; i++) {
      if (argArray[i].startsWith('--')) {
        const key = argArray[i].substring(2);
        const value = argArray[i + 1] && !argArray[i + 1].startsWith('--') 
          ? argArray[++i] 
          : true;
        args[key] = value;
      } else if (argArray[i].startsWith('-')) {
        const key = argArray[i].substring(1);
        args[key] = true;
      }
    }
    
    return args;
  }
}

CUSTOM COMMANDS:

// Deploy command
registry.register(new CustomCommand({
  name: 'deploy',
  description: 'Deploy application to environment',
  aliases: ['dep', 'd'],
  
  parameters: [
    { name: 'env', type: 'string', required: true },
    { name: 'version', type: 'string', required: true },
    { name: 'strategy', type: 'string', default: 'rolling' }
  ],
  
  validators: [
    async (args) => {
      if (!['dev', 'staging', 'prod'].includes(args.env)) {
        throw new Error('Invalid environment');
      }
    }
  ],
  
  permissions: ['deploy:execute'],
  
  action: async (args, context) => {
    const deployer = new DeploymentAgent();
    return await deployer.deploy({
      environment: args.env,
      version: args.version,
      strategy: args.strategy,
      user: context.user
    });
  }
}));

// Analyze command
registry.register(new CustomCommand({
  name: 'analyze',
  description: 'Analyze codebase',
  
  parameters: [
    { name: 'type', type: 'string', default: 'all' },
    { name: 'depth', type: 'number', default: 3 }
  ],
  
  action: async (args) => {
    const analyzer = new CodeAnalyzer();
    
    const analyses = {
      complexity: () => analyzer.analyzeComplexity(args.depth),
      security: () => analyzer.analyzeSecurity(),
      performance: () => analyzer.analyzePerformance(),
      all: async () => ({
        complexity: await analyzer.analyzeComplexity(args.depth),
        security: await analyzer.analyzeSecurity(),
        performance: await analyzer.analyzePerformance()
      })
    };
    
    return await analyses[args.type]();
  }
}));

// Generate command
registry.register(new CustomCommand({
  name: 'generate',
  description: 'Generate code artifacts',
  aliases: ['gen', 'g'],
  
  parameters: [
    { name: 'type', type: 'string', required: true },
    { name: 'name', type: 'string', required: true },
    { name: 'template', type: 'string' }
  ],
  
  action: async (args) => {
    const generators = {
      component: ComponentGenerator,
      service: ServiceGenerator,
      api: APIGenerator,
      test: TestGenerator
    };
    
    const Generator = generators[args.type];
    
    if (!Generator) {
      throw new Error(`Unknown generator type: ${args.type}`);
    }
    
    const generator = new Generator();
    return await generator.generate(args.name, args.template);
  }
}));

COMMAND EXECUTION:

// Execute commands
await registry.execute('deploy --env prod --version 2.0.0', context);
await registry.execute('analyze --type security', context);
await registry.execute('generate --type component --name UserProfile', context);

// Command chaining
class CommandChain {
  constructor(registry) {
    this.registry = registry;
    this.commands = [];
  }
  
  add(command) {
    this.commands.push(command);
    return this;
  }
  
  async execute(context) {
    const results = [];
    
    for (const command of this.commands) {
      try {
        const result = await this.registry.execute(command, context);
        results.push({ command, result, status: 'success' });
      } catch (error) {
        results.push({ command, error, status: 'failed' });
        
        if (!this.continueOnError) {
          break;
        }
      }
    }
    
    return results;
  }
}

// Chain commands
const chain = new CommandChain(registry);
await chain
  .add('analyze --type all')
  .add('generate --type test --name integration')
  .add('deploy --env staging --version latest')
  .execute(context);"
```

## Practice Exercises

### Exercise 1: Build a DevOps Workflow Template
Create a reusable workflow template for complete CI/CD pipeline including building, testing, security scanning, and deployment.

### Exercise 2: Design a Legal Document Processor
Build domain-specific sub-agents for processing legal documents, extracting clauses, and ensuring compliance.

### Exercise 3: Create a Custom Command Language
Design a domain-specific language (DSL) for your industry with custom commands and sub-agent orchestration.

## Key Takeaways

1. **Workflow templates** enable reusable, configurable automation patterns
2. **Industry-specific sub-agents** provide domain expertise and compliance
3. **Domain-driven design** ensures sub-agents align with business logic
4. **External tool integration** extends sub-agent capabilities
5. **Custom commands** create intuitive interfaces for complex operations
6. **Composition and orchestration** enable building sophisticated systems

## Next Steps

Block 9 will cover mastery topics including best practices, common pitfalls, performance optimization, and the future of agentic coding.