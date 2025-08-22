# Day 2 - Block 6: Sub-agent Optimization
## Learning Objectives
- Master sub-agent performance tuning
- Optimize context window management
- Develop efficient prompt engineering
- Implement caching and memoization
- Design batch processing strategies

## Performance Tuning Fundamentals

### Sub-agent Performance Metrics

```bash
#!/bin/bash
# performance-metrics.sh

claude-code "Implement performance monitoring system:

METRICS COLLECTOR: PerformanceMonitor

KEY METRICS:
1. Response Time
   - Sub-agent initialization: < 100ms
   - Task execution: varies
   - Result aggregation: < 50ms
   
2. Token Usage
   - Input tokens per task
   - Output tokens generated
   - Context window utilization
   
3. Success Rate
   - Task completion rate
   - Error frequency
   - Retry attempts
   
4. Resource Usage
   - Memory consumption
   - CPU utilization
   - Network bandwidth

MONITORING IMPLEMENTATION:

class SubAgentProfiler {
  constructor() {
    this.metrics = {
      executionTime: [],
      tokenUsage: [],
      successRate: 0,
      errors: []
    };
  }
  
  async profile(subAgent, task) {
    const startTime = Date.now();
    const startTokens = getTokenCount();
    
    try {
      const result = await subAgent.execute(task);
      
      this.metrics.executionTime.push(Date.now() - startTime);
      this.metrics.tokenUsage.push(getTokenCount() - startTokens);
      this.metrics.successRate++;
      
      return result;
    } catch (error) {
      this.metrics.errors.push(error);
      throw error;
    }
  }
  
  getReport() {
    return {
      avgExecutionTime: avg(this.metrics.executionTime),
      avgTokenUsage: avg(this.metrics.tokenUsage),
      successRate: this.metrics.successRate / this.metrics.executionTime.length,
      errorRate: this.metrics.errors.length / this.metrics.executionTime.length
    };
  }
}

OPTIMIZATION TARGETS:
- Reduce token usage by 40%
- Improve speed by 2x
- Achieve 99% success rate
- Minimize retries"
```

### Parallel Processing Optimization

```bash
#!/bin/bash
# parallel-optimization.sh

claude-code "Optimize parallel sub-agent execution:

OPTIMIZER: ParallelExecutionOptimizer

STRATEGIES:

Strategy 1: Work Distribution
function distributeWork(tasks, workers) {
  // Analyze task complexity
  const taskComplexity = tasks.map(analyzeComplexity);
  
  // Sort by complexity (complex first)
  tasks.sort((a, b) => b.complexity - a.complexity);
  
  // Distribute evenly by complexity
  const queues = Array(workers).fill([]);
  tasks.forEach((task, i) => {
    queues[i % workers].push(task);
  });
  
  return queues;
}

Strategy 2: Dynamic Load Balancing
class LoadBalancer {
  constructor(workers) {
    this.workers = workers;
    this.queues = workers.map(() => []);
    this.loads = workers.map(() => 0);
  }
  
  assign(task) {
    // Find least loaded worker
    const minLoadIndex = this.loads.indexOf(Math.min(...this.loads));
    
    // Assign task
    this.queues[minLoadIndex].push(task);
    this.loads[minLoadIndex] += task.estimatedTime;
    
    return minLoadIndex;
  }
  
  rebalance() {
    // Move tasks from overloaded to underloaded workers
    const avgLoad = avg(this.loads);
    
    for (let i = 0; i < this.workers; i++) {
      if (this.loads[i] > avgLoad * 1.5) {
        // Move excess tasks
        const excess = this.queues[i].splice(avgLoad);
        this.redistribute(excess);
      }
    }
  }
}

Strategy 3: Batching Similar Tasks
function batchSimilarTasks(tasks) {
  // Group by task type
  const grouped = {};
  tasks.forEach(task => {
    const type = task.type || 'default';
    grouped[type] = grouped[type] || [];
    grouped[type].push(task);
  });
  
  // Create batches
  const batches = [];
  Object.values(grouped).forEach(group => {
    while (group.length > 0) {
      batches.push(group.splice(0, BATCH_SIZE));
    }
  });
  
  return batches;
}

EXECUTION PATTERN:

async function optimizedParallelExecution(tasks) {
  const workers = determineOptimalWorkers();
  const batches = batchSimilarTasks(tasks);
  const balancer = new LoadBalancer(workers);
  
  // Assign batches to workers
  batches.forEach(batch => balancer.assign(batch));
  
  // Execute in parallel with monitoring
  const results = await Promise.all(
    balancer.queues.map(async (queue, workerIndex) => {
      return executeWorker(queue, workerIndex);
    })
  );
  
  // Rebalance if needed
  if (hasSlowWorkers(results)) {
    balancer.rebalance();
    // Re-execute unfinished tasks
  }
  
  return aggregateResults(results);
}"
```

## Context Window Management

### Efficient Context Usage

```bash
#!/bin/bash
# context-management.sh

claude-code "Implement context window optimization:

MANAGER: ContextWindowManager

CONTEXT OPTIMIZATION TECHNIQUES:

Technique 1: Context Compression
function compressContext(context) {
  // Remove redundant information
  context = removeRedundancy(context);
  
  // Summarize verbose sections
  context = summarizeLongSections(context);
  
  // Use references instead of repetition
  context = replaceWithReferences(context);
  
  // Compress whitespace and formatting
  context = minifyFormatting(context);
  
  return context;
}

Technique 2: Sliding Window
class SlidingContextWindow {
  constructor(maxSize) {
    this.maxSize = maxSize;
    this.window = [];
    this.priority = new Map();
  }
  
  add(content, priority = 1) {
    this.window.push({ content, priority });
    this.priority.set(content, priority);
    
    // Maintain window size
    while (this.getSize() > this.maxSize) {
      this.evict();
    }
  }
  
  evict() {
    // Remove lowest priority item
    const sorted = this.window.sort((a, b) => a.priority - b.priority);
    return sorted.shift();
  }
  
  getContext() {
    return this.window
      .sort((a, b) => b.priority - a.priority)
      .map(item => item.content)
      .join('\\n');
  }
}

Technique 3: Context Caching
class ContextCache {
  constructor() {
    this.cache = new Map();
    this.usage = new Map();
  }
  
  store(key, context) {
    const compressed = compress(context);
    this.cache.set(key, compressed);
    this.usage.set(key, 0);
  }
  
  retrieve(key) {
    if (this.cache.has(key)) {
      this.usage.set(key, this.usage.get(key) + 1);
      return decompress(this.cache.get(key));
    }
    return null;
  }
  
  prune() {
    // Remove least used contexts
    const sorted = Array.from(this.usage.entries())
      .sort((a, b) => a[1] - b[1]);
    
    sorted.slice(0, 10).forEach(([key]) => {
      this.cache.delete(key);
      this.usage.delete(key);
    });
  }
}

Technique 4: Incremental Context Building
function buildIncrementalContext(task) {
  let context = getBaseContext();
  
  // Add only relevant sections
  if (task.requires.includes('database')) {
    context += getDatabaseContext();
  }
  
  if (task.requires.includes('api')) {
    context += getAPIContext();
  }
  
  if (task.requires.includes('frontend')) {
    context += getFrontendContext();
  }
  
  // Trim to fit window
  return trimToWindow(context, MAX_CONTEXT_SIZE);
}

USAGE PATTERNS:

Pattern 1: Hierarchical Context
MainAgent:
  context: High-level overview (500 tokens)
  
  SubAgent1:
    context: Inherited + specific details (1000 tokens)
    
    SubSubAgent:
      context: Most specific information (1500 tokens)

Pattern 2: Shared Context Pool
SharedPool:
  - Common definitions (200 tokens)
  - Project structure (300 tokens)
  - Coding standards (200 tokens)
  
Agents draw from pool as needed

Pattern 3: Context Diff
Instead of full context:
  Base: Original context
  Diff: Only changes
  Result: Base + apply(Diff)"
```

### Token Optimization Strategies

```bash
#!/bin/bash
# token-optimization.sh

claude-code "Minimize token usage in sub-agents:

OPTIMIZER: TokenOptimizer

OPTIMIZATION STRATEGIES:

Strategy 1: Prompt Compression
function compressPrompt(prompt) {
  // Use abbreviations
  const abbreviations = {
    'function': 'fn',
    'variable': 'var',
    'parameter': 'param',
    'return': 'ret',
    'implement': 'impl'
  };
  
  Object.entries(abbreviations).forEach(([full, abbr]) => {
    prompt = prompt.replace(new RegExp(full, 'gi'), abbr);
  });
  
  // Remove unnecessary words
  const unnecessary = ['please', 'could you', 'would you'];
  unnecessary.forEach(word => {
    prompt = prompt.replace(new RegExp(word, 'gi'), '');
  });
  
  // Use symbols instead of words
  prompt = prompt
    .replace(/and/gi, '&')
    .replace(/or/gi, '|')
    .replace(/not/gi, '!')
    .replace(/greater than/gi, '>')
    .replace(/less than/gi, '<');
  
  return prompt.trim();
}

Strategy 2: Response Format Optimization
const COMPACT_FORMAT = {
  instructions: 'Output JSON only, no explanation',
  format: {
    r: 'result',
    e: 'errors',
    m: 'metadata'
  }
};

function requestCompactResponse(task) {
  return {
    task,
    format: COMPACT_FORMAT,
    maxTokens: calculateMinimalTokens(task)
  };
}

Strategy 3: Batching for Efficiency
function batchTasksForTokens(tasks) {
  const batches = [];
  let currentBatch = [];
  let currentTokens = 0;
  
  for (const task of tasks) {
    const taskTokens = estimateTokens(task);
    
    if (currentTokens + taskTokens <= MAX_TOKENS) {
      currentBatch.push(task);
      currentTokens += taskTokens;
    } else {
      batches.push(currentBatch);
      currentBatch = [task];
      currentTokens = taskTokens;
    }
  }
  
  if (currentBatch.length > 0) {
    batches.push(currentBatch);
  }
  
  return batches;
}

Strategy 4: Reuse Previous Outputs
class OutputReuseManager {
  constructor() {
    this.outputs = new Map();
  }
  
  getCacheKey(task) {
    return JSON.stringify(task);
  }
  
  async execute(task) {
    const key = this.getCacheKey(task);
    
    // Check cache
    if (this.outputs.has(key)) {
      return this.outputs.get(key);
    }
    
    // Check similar tasks
    const similar = this.findSimilar(task);
    if (similar) {
      const adapted = this.adaptOutput(similar, task);
      if (adapted) return adapted;
    }
    
    // Execute new
    const result = await executeTask(task);
    this.outputs.set(key, result);
    
    return result;
  }
  
  findSimilar(task) {
    for (const [key, output] of this.outputs) {
      const similarity = calculateSimilarity(task, JSON.parse(key));
      if (similarity > 0.8) {
        return output;
      }
    }
    return null;
  }
}

TOKEN SAVING RESULTS:
- Prompt compression: -30% tokens
- Compact format: -40% output tokens
- Batching: -25% total tokens
- Output reuse: -60% for similar tasks
- Combined: Up to -70% token reduction"
```

## Efficient Prompt Engineering

### Prompt Template System

```bash
#!/bin/bash
# prompt-templates.sh

claude-code "Create efficient prompt template system:

SYSTEM: PromptTemplateEngine

TEMPLATE LIBRARY:

Template 1: Minimal Task Prompt
{
  type: 'minimal',
  template: 'Task: {{task}}\\nOutput: {{format}}',
  tokens: 10-20
}

Template 2: Structured Analysis
{
  type: 'analysis',
  template: '''
  Analyze: {{target}}
  Metrics: {{metrics}}
  Format: JSON
  ''',
  tokens: 20-30
}

Template 3: Code Generation
{
  type: 'codegen',
  template: '''
  Gen {{language}} {{type}}:
  Name: {{name}}
  Params: {{params}}
  Logic: {{logic}}
  ''',
  tokens: 30-50
}

PROMPT OPTIMIZATION:

class PromptOptimizer {
  constructor() {
    this.templates = loadTemplates();
    this.history = [];
  }
  
  optimize(task) {
    // Select best template
    const template = this.selectTemplate(task);
    
    // Fill template efficiently
    const filled = this.fillTemplate(template, task);
    
    // Compress if needed
    if (countTokens(filled) > MAX_PROMPT_TOKENS) {
      return this.compress(filled);
    }
    
    return filled;
  }
  
  selectTemplate(task) {
    // Find most specific template
    const candidates = this.templates.filter(t => 
      t.type === task.type
    );
    
    // Return shortest matching template
    return candidates.sort((a, b) => 
      a.tokens - b.tokens
    )[0];
  }
  
  fillTemplate(template, data) {
    let result = template.template;
    
    // Replace placeholders
    Object.entries(data).forEach(([key, value]) => {
      // Truncate long values
      if (value.length > 100) {
        value = value.substring(0, 97) + '...';
      }
      
      result = result.replace(
        new RegExp(`{{${key}}}`, 'g'),
        value
      );
    });
    
    return result;
  }
  
  compress(prompt) {
    // Progressive compression
    const compressionLevels = [
      this.removeWhitespace,
      this.abbreviate,
      this.removeOptional,
      this.summarize
    ];
    
    for (const compress of compressionLevels) {
      prompt = compress(prompt);
      if (countTokens(prompt) <= MAX_PROMPT_TOKENS) {
        break;
      }
    }
    
    return prompt;
  }
}

ADVANCED TECHNIQUES:

Technique 1: Few-Shot Learning
function createFewShotPrompt(task, examples) {
  const prompt = [];
  
  // Add minimal examples
  const minExamples = selectBestExamples(examples, task, 2);
  
  minExamples.forEach(ex => {
    prompt.push(`In: ${ex.input}`);
    prompt.push(`Out: ${ex.output}`);
  });
  
  prompt.push(`In: ${task.input}`);
  prompt.push('Out:');
  
  return prompt.join('\\n');
}

Technique 2: Chain of Thought Compression
function compressChainOfThought(task) {
  return `
Think step-by-step:
1. ${task.step1}
2. ${task.step2}
3. Result
Output only final answer.
  `.trim();
}

Technique 3: Meta-Prompting
function createMetaPrompt(task) {
  return `
Role: ${task.role}
Task: ${task.description}
Constraints: ${task.constraints.join(',')}
Format: ${task.outputFormat}
  `.trim();
}"
```

### Dynamic Prompt Generation

```bash
#!/bin/bash
# dynamic-prompts.sh

claude-code "Build dynamic prompt generation system:

GENERATOR: DynamicPromptGenerator

ADAPTIVE GENERATION:

class AdaptivePromptGenerator {
  constructor() {
    this.performance = new Map();
    this.templates = new Map();
  }
  
  generate(task, context) {
    // Analyze task complexity
    const complexity = this.analyzeComplexity(task);
    
    // Select strategy based on complexity
    if (complexity < 3) {
      return this.simplePrompt(task);
    } else if (complexity < 7) {
      return this.structuredPrompt(task, context);
    } else {
      return this.detailedPrompt(task, context);
    }
  }
  
  simplePrompt(task) {
    return `${task.action} ${task.target}`;
  }
  
  structuredPrompt(task, context) {
    return `
Context: ${this.summarize(context, 50)}
Task: ${task.action} ${task.target}
Requirements: ${task.requirements.slice(0, 3).join(', ')}
    `.trim();
  }
  
  detailedPrompt(task, context) {
    return `
Background:
${this.summarize(context, 100)}

Objective:
${task.description}

Specific Requirements:
${task.requirements.map((r, i) => `${i+1}. ${r}`).join('\\n')}

Constraints:
${task.constraints.join(', ')}

Expected Output:
${task.outputSpec}
    `.trim();
  }
  
  learn(prompt, result) {
    // Track performance
    const score = this.evaluateResult(result);
    this.performance.set(prompt, score);
    
    // Adjust generation strategy
    if (score < 0.5) {
      this.adjustComplexityThreshold(-1);
    } else if (score > 0.9) {
      this.adjustComplexityThreshold(1);
    }
  }
}

CONTEXT-AWARE PROMPTING:

function createContextAwarePrompt(task, fullContext) {
  // Extract only relevant context
  const relevantContext = extractRelevant(fullContext, task);
  
  // Build layered prompt
  const layers = {
    core: task.description,
    context: relevantContext.slice(0, 100),
    details: task.requirements,
    format: task.outputFormat
  };
  
  // Assemble based on token budget
  let prompt = layers.core;
  let tokens = countTokens(prompt);
  
  for (const [key, value] of Object.entries(layers)) {
    if (key === 'core') continue;
    
    const layerTokens = countTokens(value);
    if (tokens + layerTokens <= MAX_TOKENS) {
      prompt += `\\n${value}`;
      tokens += layerTokens;
    }
  }
  
  return prompt;
}

PROMPT EVOLUTION:

class EvolvingPromptSystem {
  constructor() {
    this.generations = [];
    this.fitness = new Map();
  }
  
  evolve(basePrompt, iterations = 10) {
    let population = this.createInitialPopulation(basePrompt);
    
    for (let i = 0; i < iterations; i++) {
      // Evaluate fitness
      population.forEach(prompt => {
        const score = this.evaluate(prompt);
        this.fitness.set(prompt, score);
      });
      
      // Select best performers
      const selected = this.select(population);
      
      // Create next generation
      population = this.crossoverAndMutate(selected);
    }
    
    // Return best prompt
    return this.getBest(population);
  }
  
  createInitialPopulation(base) {
    return [
      base,
      this.mutate(base, 'abbreviate'),
      this.mutate(base, 'expand'),
      this.mutate(base, 'restructure'),
      this.mutate(base, 'simplify')
    ];
  }
  
  mutate(prompt, strategy) {
    switch(strategy) {
      case 'abbreviate':
        return abbreviate(prompt);
      case 'expand':
        return addDetails(prompt);
      case 'restructure':
        return reorganize(prompt);
      case 'simplify':
        return simplify(prompt);
    }
  }
}"
```

## Caching and Memoization

### Multi-Level Caching System

```bash
#!/bin/bash
# caching-system.sh

claude-code "Implement multi-level caching for sub-agents:

SYSTEM: SubAgentCacheManager

CACHE ARCHITECTURE:

Level 1: Memory Cache (Hot)
- Size: 100 MB
- TTL: 5 minutes
- Hit ratio target: 60%

Level 2: Disk Cache (Warm)
- Size: 1 GB
- TTL: 1 hour
- Hit ratio target: 30%

Level 3: Distributed Cache (Cold)
- Size: 10 GB
- TTL: 24 hours
- Hit ratio target: 10%

IMPLEMENTATION:

class MultiLevelCache {
  constructor() {
    this.l1 = new MemoryCache(100 * MB);
    this.l2 = new DiskCache(1 * GB);
    this.l3 = new RedisCache(10 * GB);
    this.stats = new CacheStats();
  }
  
  async get(key) {
    // Check L1 (fastest)
    let value = this.l1.get(key);
    if (value) {
      this.stats.hit('l1');
      return value;
    }
    
    // Check L2
    value = await this.l2.get(key);
    if (value) {
      this.stats.hit('l2');
      this.l1.set(key, value); // Promote to L1
      return value;
    }
    
    // Check L3
    value = await this.l3.get(key);
    if (value) {
      this.stats.hit('l3');
      this.promote(key, value);
      return value;
    }
    
    this.stats.miss();
    return null;
  }
  
  async set(key, value, ttl) {
    // Write to all levels
    this.l1.set(key, value, ttl);
    await this.l2.set(key, value, ttl * 2);
    await this.l3.set(key, value, ttl * 4);
  }
  
  promote(key, value) {
    // Move hot items up
    this.l2.set(key, value);
    this.l1.set(key, value);
  }
  
  evict() {
    // LRU eviction
    this.l1.evictLRU();
    
    // Move evicted items down
    const evicted = this.l1.getEvicted();
    evicted.forEach(item => {
      this.l2.set(item.key, item.value);
    });
  }
}

CACHE KEY GENERATION:

function generateCacheKey(task, context) {
  const normalized = {
    task: normalizeTask(task),
    contextHash: hashContext(context),
    version: CACHE_VERSION
  };
  
  return crypto
    .createHash('sha256')
    .update(JSON.stringify(normalized))
    .digest('hex');
}

function normalizeTask(task) {
  // Remove volatile data
  const { timestamp, randomId, ...stable } = task;
  
  // Sort properties
  return Object.keys(stable)
    .sort()
    .reduce((obj, key) => {
      obj[key] = stable[key];
      return obj;
    }, {});
}

INTELLIGENT CACHING:

class SmartCache {
  constructor() {
    this.cache = new MultiLevelCache();
    this.predictor = new AccessPredictor();
    this.prefetcher = new Prefetcher();
  }
  
  async get(key, task) {
    // Check cache
    let result = await this.cache.get(key);
    
    if (!result) {
      // Execute and cache
      result = await this.execute(task);
      await this.cache.set(key, result, this.calculateTTL(task));
      
      // Prefetch related
      this.prefetchRelated(task);
    }
    
    // Predict future access
    this.predictor.record(key);
    
    return result;
  }
  
  calculateTTL(task) {
    // Dynamic TTL based on task type
    const baseTTL = {
      'analysis': 3600,    // 1 hour
      'generation': 1800,  // 30 min
      'validation': 300,   // 5 min
      'realtime': 60       // 1 min
    };
    
    return baseTTL[task.type] || 600;
  }
  
  async prefetchRelated(task) {
    const related = this.findRelatedTasks(task);
    
    related.forEach(async relatedTask => {
      const key = generateCacheKey(relatedTask);
      if (!await this.cache.exists(key)) {
        // Prefetch in background
        this.prefetcher.fetch(relatedTask);
      }
    });
  }
}"
```

### Memoization Patterns

```bash
#!/bin/bash
# memoization.sh

claude-code "Implement advanced memoization for sub-agents:

SYSTEM: MemoizationFramework

MEMOIZATION STRATEGIES:

Strategy 1: Function-Level Memoization
function memoize(fn, options = {}) {
  const cache = new Map();
  const maxSize = options.maxSize || 1000;
  const ttl = options.ttl || Infinity;
  
  return async function(...args) {
    const key = JSON.stringify(args);
    
    // Check cache
    if (cache.has(key)) {
      const cached = cache.get(key);
      if (Date.now() - cached.timestamp < ttl) {
        return cached.value;
      }
      cache.delete(key);
    }
    
    // Execute and cache
    const result = await fn.apply(this, args);
    
    cache.set(key, {
      value: result,
      timestamp: Date.now()
    });
    
    // Maintain size limit
    if (cache.size > maxSize) {
      const firstKey = cache.keys().next().value;
      cache.delete(firstKey);
    }
    
    return result;
  };
}

Strategy 2: Partial Result Memoization
class PartialMemoizer {
  constructor() {
    this.partials = new Map();
  }
  
  async execute(task) {
    const steps = this.decompose(task);
    const results = [];
    
    for (const step of steps) {
      const stepKey = this.getStepKey(step);
      
      // Check if step result is memoized
      if (this.partials.has(stepKey)) {
        results.push(this.partials.get(stepKey));
      } else {
        // Execute step
        const result = await this.executeStep(step);
        this.partials.set(stepKey, result);
        results.push(result);
      }
    }
    
    return this.combine(results);
  }
  
  decompose(task) {
    // Break task into cacheable steps
    return task.steps || [task];
  }
  
  combine(results) {
    // Combine partial results
    return results.reduce((acc, result) => {
      return { ...acc, ...result };
    }, {});
  }
}

Strategy 3: Fuzzy Memoization
class FuzzyMemoizer {
  constructor(threshold = 0.9) {
    this.cache = new Map();
    this.threshold = threshold;
  }
  
  async get(task) {
    // Find similar cached results
    for (const [key, value] of this.cache) {
      const similarity = this.calculateSimilarity(task, key);
      
      if (similarity >= this.threshold) {
        // Adapt cached result to new task
        return this.adapt(value, task, key);
      }
    }
    
    // No similar result found
    const result = await this.execute(task);
    this.cache.set(task, result);
    
    return result;
  }
  
  calculateSimilarity(task1, task2) {
    // Implement similarity algorithm
    const features1 = this.extractFeatures(task1);
    const features2 = this.extractFeatures(task2);
    
    return cosineSimilarity(features1, features2);
  }
  
  adapt(cachedResult, newTask, cachedTask) {
    // Adapt cached result to new task
    const differences = this.findDifferences(newTask, cachedTask);
    
    return this.applyDifferences(cachedResult, differences);
  }
}

MEMOIZATION OPTIMIZATION:

class OptimizedMemoization {
  constructor() {
    this.cache = new Map();
    this.hits = 0;
    this.misses = 0;
  }
  
  shouldMemoize(task) {
    // Determine if task is worth memoizing
    const factors = {
      complexity: task.complexity > 5,
      frequency: this.getFrequency(task.type) > 10,
      deterministic: !task.random,
      expensive: task.estimatedTime > 1000
    };
    
    const score = Object.values(factors)
      .filter(Boolean).length;
    
    return score >= 2;
  }
  
  async execute(task) {
    if (!this.shouldMemoize(task)) {
      return await this.runTask(task);
    }
    
    const key = this.getKey(task);
    
    if (this.cache.has(key)) {
      this.hits++;
      return this.cache.get(key);
    }
    
    this.misses++;
    const result = await this.runTask(task);
    
    // Selective caching based on result
    if (this.shouldCacheResult(result)) {
      this.cache.set(key, result);
    }
    
    return result;
  }
  
  shouldCacheResult(result) {
    // Don't cache errors or large results
    return !result.error && 
           JSON.stringify(result).length < 10000;
  }
  
  getEfficiency() {
    const total = this.hits + this.misses;
    return {
      hitRate: this.hits / total,
      efficiency: (this.hits * AVG_COMPUTE_TIME) / total
    };
  }
}"
```

## Batch Processing Strategies

### Efficient Batch Operations

```bash
#!/bin/bash
# batch-processing.sh

claude-code "Implement batch processing optimization:

SYSTEM: BatchProcessingOptimizer

BATCHING STRATEGIES:

Strategy 1: Intelligent Batching
class IntelligentBatcher {
  constructor() {
    this.queue = [];
    this.batchSize = this.calculateOptimalBatchSize();
    this.timeout = 100; // ms
  }
  
  calculateOptimalBatchSize() {
    // Determine based on task type and resources
    const factors = {
      cpuCores: os.cpus().length,
      memoryAvailable: os.freemem() / (1024 * 1024),
      taskComplexity: this.avgTaskComplexity,
      latencyTarget: 1000 // ms
    };
    
    // Formula for optimal batch size
    return Math.min(
      factors.cpuCores * 2,
      Math.floor(factors.memoryAvailable / 100),
      Math.floor(factors.latencyTarget / factors.taskComplexity)
    );
  }
  
  async add(task) {
    this.queue.push(task);
    
    // Process if batch is full
    if (this.queue.length >= this.batchSize) {
      return await this.processBatch();
    }
    
    // Or set timeout for partial batch
    if (this.queue.length === 1) {
      setTimeout(() => this.processBatch(), this.timeout);
    }
    
    return new Promise(resolve => {
      task.resolver = resolve;
    });
  }
  
  async processBatch() {
    const batch = this.queue.splice(0, this.batchSize);
    
    // Group similar tasks
    const grouped = this.groupSimilarTasks(batch);
    
    // Process groups in parallel
    const results = await Promise.all(
      grouped.map(group => this.processGroup(group))
    );
    
    // Resolve individual promises
    results.flat().forEach((result, i) => {
      if (batch[i].resolver) {
        batch[i].resolver(result);
      }
    });
    
    return results;
  }
  
  groupSimilarTasks(tasks) {
    const groups = {};
    
    tasks.forEach(task => {
      const type = task.type || 'default';
      groups[type] = groups[type] || [];
      groups[type].push(task);
    });
    
    return Object.values(groups);
  }
}

Strategy 2: Pipeline Batching
class PipelineBatcher {
  constructor(stages) {
    this.stages = stages;
    this.buffers = stages.map(() => []);
  }
  
  async process(items) {
    // Initial batch
    this.buffers[0] = items;
    
    // Process through pipeline
    for (let i = 0; i < this.stages.length; i++) {
      const stage = this.stages[i];
      const input = this.buffers[i];
      
      // Process stage in batches
      const output = await this.processStage(stage, input);
      
      // Feed to next stage
      if (i < this.stages.length - 1) {
        this.buffers[i + 1] = output;
      } else {
        return output;
      }
    }
  }
  
  async processStage(stage, items) {
    const batchSize = stage.optimalBatchSize || 10;
    const results = [];
    
    // Process in optimal batch sizes
    for (let i = 0; i < items.length; i += batchSize) {
      const batch = items.slice(i, i + batchSize);
      
      // Parallel processing within batch
      const batchResults = await Promise.all(
        batch.map(item => stage.process(item))
      );
      
      results.push(...batchResults);
    }
    
    return results;
  }
}

Strategy 3: Adaptive Batching
class AdaptiveBatcher {
  constructor() {
    this.metrics = {
      throughput: [],
      latency: [],
      errorRate: []
    };
    this.currentBatchSize = 10;
  }
  
  async processBatch(tasks) {
    const startTime = Date.now();
    
    try {
      // Process with current batch size
      const results = await this.execute(
        tasks.slice(0, this.currentBatchSize)
      );
      
      // Record metrics
      const duration = Date.now() - startTime;
      this.metrics.throughput.push(results.length / duration);
      this.metrics.latency.push(duration);
      
      // Adapt batch size
      this.adaptBatchSize();
      
      return results;
    } catch (error) {
      this.metrics.errorRate.push(1);
      this.reduceBatchSize();
      throw error;
    }
  }
  
  adaptBatchSize() {
    const recentThroughput = avg(this.metrics.throughput.slice(-10));
    const recentLatency = avg(this.metrics.latency.slice(-10));
    
    // Increase if performing well
    if (recentLatency < TARGET_LATENCY && 
        recentThroughput > THROUGHPUT_THRESHOLD) {
      this.currentBatchSize = Math.min(
        this.currentBatchSize * 1.2,
        MAX_BATCH_SIZE
      );
    }
    
    // Decrease if struggling
    if (recentLatency > TARGET_LATENCY * 1.5 ||
        this.metrics.errorRate.slice(-5).includes(1)) {
      this.currentBatchSize = Math.max(
        this.currentBatchSize * 0.8,
        MIN_BATCH_SIZE
      );
    }
  }
}

BATCH OPTIMIZATION RESULTS:
- 5x throughput improvement
- 60% latency reduction
- 40% resource utilization improvement
- 80% fewer API calls
- 50% cost reduction"
```

## Practice Exercises

### Exercise 1: Build a Token Budget Manager
Create a system that dynamically allocates token budgets to sub-agents based on task priority and complexity.

### Exercise 2: Design an Adaptive Cache Warmer
Build a cache warming system that predicts which tasks will be needed and pre-executes them during idle time.

### Exercise 3: Implement a Smart Batch Aggregator
Create a system that intelligently groups tasks for batch processing based on similarity and resource requirements.

## Key Takeaways

1. **Performance monitoring** is essential for optimization
2. **Context window management** dramatically reduces token usage
3. **Efficient prompting** can cut tokens by 70%
4. **Caching and memoization** eliminate redundant work
5. **Batch processing** improves throughput by 5x
6. **Continuous optimization** based on metrics leads to sustained improvements

## Next Steps

Day 3 Block 7 will explore real-world projects, building complete applications with optimized sub-agent systems.