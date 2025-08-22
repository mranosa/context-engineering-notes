# 🚀 Claude Code CLI Sub-agents: 3-Day Mastery Program

A comprehensive learning program for mastering Claude Code CLI sub-agents, from basics to advanced orchestration and real-world applications.

## 📚 What You'll Learn

This intensive 3-day program takes you from zero to mastery in Claude Code CLI sub-agents:

- **Day 1**: Fundamentals, specialized sub-agents, and orchestration patterns
- **Day 2**: Advanced patterns, project automation, and optimization techniques  
- **Day 3**: Real-world projects, custom workflows, and mastery principles

## 🎯 Learning Objectives

By completing this program, you will:

1. **Master Sub-agent Creation** - Build any type of specialized sub-agent
2. **Design Complex Workflows** - Orchestrate multiple sub-agents effectively
3. **Optimize Performance** - Reduce token usage and improve execution speed
4. **Build Production Systems** - Create real-world applications with sub-agents
5. **Develop Custom Solutions** - Design domain-specific sub-agent systems

## 📖 Program Structure

### Day 1: Foundation
- **Block 1**: [Sub-agent Basics](study-blocks/day1-block1-subagent-basics.md) (2 hours)
- **Block 2**: [Specialized Sub-agents](study-blocks/day1-block2-specialized-subagents.md) (2 hours)
- **Block 3**: [Orchestration](study-blocks/day1-block3-orchestration.md) (2 hours)

### Day 2: Advanced Techniques
- **Block 4**: [Advanced Patterns](study-blocks/day2-block4-advanced-patterns.md) (2 hours)
- **Block 5**: [Project Automation](study-blocks/day2-block5-project-automation.md) (2 hours)
- **Block 6**: [Optimization](study-blocks/day2-block6-optimization.md) (2 hours)

### Day 3: Mastery & Real-world Application
- **Block 7**: [Real-world Projects](study-blocks/day3-block7-realworld-projects.md) (2 hours)
- **Block 8**: [Custom Workflows](study-blocks/day3-block8-custom-workflows.md) (2 hours)
- **Block 9**: [Mastery](study-blocks/day3-block9-mastery.md) (2 hours)

## 🛠️ Prerequisites

### Required Software
- **Claude Code CLI** installed and configured
- **Git** for version control
- **Node.js** (v16+) or **Python** (3.8+) depending on your preference
- **Docker** (optional, for containerization examples)
- A code editor (VS Code recommended)

### Installation

1. **Install Claude Code CLI**:
```bash
# Check if Claude Code CLI is installed
claude-code --version

# If not installed, follow official installation guide
# https://docs.anthropic.com/claude-code/installation
```

2. **Clone this repository**:
```bash
git clone https://github.com/yourusername/3-day-learning.git
cd 3-day-learning
```

3. **Make example scripts executable**:
```bash
chmod +x examples/*.sh
```

## 🏃 Quick Start

### Your First Sub-agent

Try this simple example to test your setup:

```bash
claude-code "You are a FileAnalyzer sub-agent. List all JavaScript files in the current directory and count their lines of code."
```

### Run an Example Script

```bash
# Analyze files in your project
./examples/example-file-processor.sh -d ./src -t js -a analyze

# Generate tests for a specific file
./examples/example-test-generator.sh -f app.js -t unit -r jest
```

## 📂 Repository Structure

```
3-day-learning/
├── study-blocks/          # Day-by-day learning materials
│   ├── day1-block1-subagent-basics.md
│   ├── day1-block2-specialized-subagents.md
│   └── ...
├── examples/              # Ready-to-run example scripts
│   ├── example-file-processor.sh
│   ├── example-code-migrator.sh
│   ├── example-test-generator.sh
│   ├── example-api-builder.sh
│   └── example-orchestrator.sh
├── rituals/               # Energy management & study techniques
│   └── energy-management.md
└── README.md              # You are here!
```

## 💡 Example Scripts

### 1. File Processor
Analyzes, optimizes, or formats files in your codebase.
```bash
./examples/example-file-processor.sh --help
```

### 2. Code Migrator
Migrates code between frameworks or versions.
```bash
./examples/example-code-migrator.sh -s react16 -t react18 -d ./src
```

### 3. Test Generator
Creates comprehensive test suites automatically.
```bash
./examples/example-test-generator.sh -d ./src -t unit -c 90
```

### 4. API Builder
Generates complete REST APIs with documentation.
```bash
./examples/example-api-builder.sh -n users -m GET,POST,PUT,DELETE -s
```

### 5. Orchestrator
Coordinates multiple sub-agents for complex workflows.
```bash
./examples/example-orchestrator.sh -p my-app full-stack
```

## 🎓 Study Plan

### Recommended Schedule

#### Option 1: Intensive (3 Days)
- **Day 1**: Complete Blocks 1-3 (6 hours)
- **Day 2**: Complete Blocks 4-6 (6 hours)
- **Day 3**: Complete Blocks 7-9 (6 hours)

#### Option 2: Balanced (6 Days)
- **Days 1-2**: Blocks 1-3 (3 hours/day)
- **Days 3-4**: Blocks 4-6 (3 hours/day)
- **Days 5-6**: Blocks 7-9 (3 hours/day)

#### Option 3: Relaxed (9 Days)
- Complete one block per day (2 hours/day)
- Review and practice on the 10th day

### Daily Routine
1. **Morning** (2 hours): Study one block thoroughly
2. **Afternoon** (1 hour): Practice with examples
3. **Evening** (30 min): Review and document learnings

## ⚡ Energy Management

Check out the [Energy Management Guide](rituals/energy-management.md) for:
- Personalized study rhythms
- Focus optimization techniques
- Break and recovery strategies
- Performance tracking methods

## 🚦 Progress Tracking

### Daily Checklist
- [ ] Completed morning study block
- [ ] Ran all example code
- [ ] Created own sub-agent variation
- [ ] Documented key learnings
- [ ] Pushed code to repository

### Milestone Projects

#### After Day 1
Build a simple file processing pipeline with 3 sub-agents.

#### After Day 2
Create an automated code review system with optimization.

#### After Day 3
Design and implement a complete application with orchestrated sub-agents.

## 💬 Common Commands

### Basic Sub-agent Invocation
```bash
# Simple task
claude-code "Analyze this codebase and report complexity metrics"

# With specific role
claude-code --role "TestGenerator" "Create unit tests for utils.js"

# With context file
claude-code --context requirements.md "Build API based on requirements"
```

### Parallel Sub-agents
```bash
# Launch multiple sub-agents
claude-code "Generate tests" &
claude-code "Update documentation" &
claude-code "Optimize performance" &
wait
```

### Pipeline Pattern
```bash
# Sequential pipeline
claude-code "Analyze code" | \
claude-code "Generate improvements" | \
claude-code "Apply changes"
```

## 🐛 Troubleshooting

### Issue: Claude Code CLI not responding
```bash
# Check CLI status
claude-code --status

# Restart CLI service
claude-code --restart
```

### Issue: Sub-agent fails to complete task
- Break down complex tasks into smaller ones
- Provide more specific instructions
- Check context window limits
- Review error messages for clues

### Issue: High token usage
- Use the optimization techniques from Block 6
- Implement caching strategies
- Batch similar operations
- Compress context when possible

## 📚 Additional Resources

### Documentation
- [Claude Code Official Docs](https://docs.anthropic.com/claude-code)
- [API Reference](https://docs.anthropic.com/claude-code/api)
- [Best Practices Guide](https://docs.anthropic.com/claude-code/best-practices)

### Community
- [Discord Community](https://discord.gg/claude-code)
- [GitHub Discussions](https://github.com/anthropics/claude-code/discussions)
- [Stack Overflow Tag](https://stackoverflow.com/questions/tagged/claude-code)

### Video Tutorials
- [Getting Started with Sub-agents](https://youtube.com/watch?v=...)
- [Advanced Orchestration Patterns](https://youtube.com/watch?v=...)
- [Real-world Case Studies](https://youtube.com/watch?v=...)

## 🤝 Contributing

Found an issue or want to add an example? Contributions are welcome!

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This learning program is open source and available under the MIT License.

## 🙏 Acknowledgments

- Anthropic team for creating Claude Code CLI
- Community contributors for examples and feedback
- All learners who help improve this program

## 🎯 Final Tips

1. **Practice Daily** - Consistency beats intensity
2. **Build Real Projects** - Apply learning immediately
3. **Share Knowledge** - Teach others what you learn
4. **Experiment Freely** - Break things and learn why
5. **Join Community** - Learn from others' experiences

## 🚀 Ready to Master Sub-agents?

Start with [Day 1 - Block 1: Sub-agent Basics](study-blocks/day1-block1-subagent-basics.md) and begin your journey to becoming a Claude Code CLI expert!

Remember: The goal isn't just to complete the program, but to gain practical skills you can apply immediately. Take your time, experiment with the examples, and build something amazing!

**Happy Learning! 🎓**

---

*"The best way to learn is by doing. The best way to master is by teaching. The best way to innovate is by combining what you've learned in new ways."*