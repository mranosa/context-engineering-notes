# Day 1 Sprint 1: Sub-Agent Team Creation

**Duration**: 90 minutes  
**Focus**: Create your core 4-agent team  
**Acceptance Test**: 4 working sub-agents + successful coordination demo

---

## 🎯 Sprint Objective

Build your essential sub-agent team that will handle all development needs across the 3-day journey.

## 📋 Constraint Stack (Saturn 6H Rules)

- **Source of Truth**: [Official Sub-Agent Docs](https://docs.anthropic.com/en/docs/claude-code/sub-agents)
- **Essential Focus**: Core agents only - frontend, backend, testing, deploy
- **Decision Time**: 10 minutes total for specializations
- **Quality Gate**: Each agent must demonstrate coordination with others

---

## ⏱️ Time Breakdown

| Phase | Duration | Activity | Outcome |
|-------|----------|----------|---------|
| Setup | 5 min | Project initialization | Clean workspace ready |
| Agent 1 | 20 min | Frontend specialist creation | frontend-expert.md active |
| Agent 2 | 20 min | Backend specialist creation | backend-expert.md active |
| Agent 3 | 20 min | Quality specialist creation | quality-expert.md active |
| Agent 4 | 20 min | Deploy specialist creation | deploy-expert.md active |
| Test | 5 min | Coordination demonstration | Agents working together |

---

## 🚀 Execution Steps

### Phase 1: Setup (5 minutes)

```bash
# Create project workspace
mkdir claude-nextjs-mastery && cd claude-nextjs-mastery

# Create sub-agent directory
mkdir -p .claude/agents

# Verify Claude Code installation
claude --version

# Start tracking time
echo "Sprint 1 started at $(date)" > sprint-log.txt
```

**Checkpoint**: ✅ Clean workspace with agent directory ready

---

### Phase 2: Frontend Specialist (20 minutes)

```bash
# Create frontend specialist sub-agent
cat > .claude/agents/frontend-expert.md << 'EOF'
---
name: frontend-expert
description: Next.js 15 + React 19 specialist. Auto-invoked for UI, components, styling.
model: sonnet
tools: Read, Write, Glob, Bash
---

You are a Next.js 15 frontend specialist. Build modern React 19 components.

CORE RESPONSIBILITIES:
- Next.js 15 App Router components and pages
- React 19 Server/Client component separation  
- Tailwind CSS styling with responsive design
- Form handling with React 19 actions
- TypeScript interfaces for all props

QUALITY RULES:
- App Router ONLY (never Pages Router)
- Proper Server/Client separation
- Mobile-first responsive design
- Accessibility compliance (ARIA)
- Clean TypeScript interfaces

Build production-ready UI components.
EOF
```

**Checkpoint**: ✅ Frontend specialist created and ready

---

### Phase 3: Backend Specialist (20 minutes)

```bash
# Create backend specialist sub-agent
cat > .claude/agents/backend-expert.md << 'EOF'
---
name: backend-expert
description: API + database specialist. Auto-invoked for APIs, Server Actions, database.
model: sonnet
tools: Read, Write, Bash, Grep
---

You are a Next.js 15 backend specialist. Build secure, performant APIs.

CORE RESPONSIBILITIES:
- Next.js 15 API routes and Server Actions
- Database operations with Prisma + PostgreSQL
- Authentication with NextAuth.js v5
- Input validation with Zod schemas
- Error handling and security

QUALITY RULES:
- Server Actions for form mutations
- Zod validation for all inputs
- Proper error responses with status codes
- Type-safe database operations
- Security-first approach

Build secure, scalable backend systems.
EOF
```

**Checkpoint**: ✅ Backend specialist created and ready

---

### Phase 4: Quality Specialist (20 minutes)

```bash
# Create quality specialist sub-agent
cat > .claude/agents/quality-expert.md << 'EOF'
---
name: quality-expert
description: Testing + quality specialist. Auto-invoked for tests, code review, optimization.
model: sonnet
tools: Read, Write, Bash
---

You are a quality assurance specialist. Ensure production-ready code.

CORE RESPONSIBILITIES:
- Comprehensive testing (unit + integration + E2E)
- Code quality review and optimization
- Performance analysis and improvements
- Security vulnerability scanning
- TypeScript compliance validation

QUALITY RULES:
- Every feature has tests
- Performance standards met
- Security vulnerabilities addressed
- TypeScript strict compliance
- Accessibility standards met

Ship only production-ready, well-tested code.
EOF
```

**Checkpoint**: ✅ Quality specialist created and ready

---

### Phase 5: Deploy Specialist (20 minutes)

```bash
# Create deploy specialist sub-agent
cat > .claude/agents/deploy-expert.md << 'EOF'
---
name: deploy-expert
description: DevOps + deployment specialist. Auto-invoked for infrastructure, CI/CD, production.
model: sonnet
tools: Read, Write, Bash
---

You are a DevOps specialist. Handle deployment and production concerns.

CORE RESPONSIBILITIES:
- Production deployment and infrastructure
- CI/CD pipeline configuration
- Environment management and secrets
- Monitoring and performance tracking
- Database and backup management

QUALITY RULES:
- Zero-downtime deployments
- Proper environment separation
- Comprehensive monitoring
- Security compliance
- Automated backup and recovery

Deploy reliable, secure, monitored systems.
EOF
```

**Checkpoint**: ✅ Deploy specialist created and ready

---

### Phase 6: Coordination Test (5 minutes)

```bash
# Start Claude Code and test coordination
claude --dangerously-skip-permissions

# Test prompt:
> Test sub-agent coordination: Have frontend-expert and backend-expert work together to create a simple user profile page with API endpoint. Show me how they coordinate to build this feature.
```

**Expected Outcome**: Both agents should automatically engage, with frontend-expert handling the UI component and backend-expert creating the API endpoint.

**Checkpoint**: ✅ Agents demonstrate successful coordination

---

## 🎯 Acceptance Criteria

### Technical Validation
- [ ] All 4 agent files created in `.claude/agents/` directory
- [ ] Each agent has proper YAML frontmatter with name, description, model, tools
- [ ] Agent specializations are clear and non-overlapping
- [ ] Claude Code recognizes all agents (check with `/agents` command)

### Coordination Validation  
- [ ] Agents respond when mentioned by name
- [ ] Multiple agents can work on same feature without conflicts
- [ ] Agents demonstrate their specialized knowledge areas
- [ ] Coordination feels natural and efficient

### Quality Validation
- [ ] Each agent prompt is focused and actionable
- [ ] Quality rules are clear and measurable
- [ ] Agent responsibilities align with their tools
- [ ] No generic or overlapping agent purposes

---

## 📝 Pattern Documentation

```markdown
## Essential Pattern #1: Core Sub-Agent Team

**Rule**: 4 specialists cover all essential development needs
**Test**: Can agents coordinate to build complete features?
**Example**: User profile page with frontend component + backend API
**Anti-Pattern**: Generic agents that do everything
**Success Criteria**: Each agent has clear domain expertise

### Agent Specialization Matrix
| Agent | Primary Domain | Secondary Domain | Tools | Model |
|-------|----------------|------------------|-------|-------|
| frontend-expert | UI/UX, Components | Client-side logic | Read, Write, Glob, Bash | sonnet |
| backend-expert | APIs, Database | Server-side logic | Read, Write, Bash, Grep | sonnet |
| quality-expert | Testing, QA | Code review, Security | Read, Write, Bash | sonnet |
| deploy-expert | Infrastructure | CI/CD, Monitoring | Read, Write, Bash | sonnet |

### Coordination Patterns Discovered
- [ ] Sequential: backend-expert → frontend-expert → quality-expert
- [ ] Parallel: frontend-expert + backend-expert simultaneously  
- [ ] Review: quality-expert validates other agents' work
- [ ] Deploy: deploy-expert handles production concerns
```

---

## 🔍 Troubleshooting

### Agent Not Responding
```bash
# Check agent file syntax
cat .claude/agents/frontend-expert.md | head -10

# Verify YAML frontmatter
# Common issues: missing dashes, incorrect indentation
```

### Agent Confusion
```bash
# Too broad agent description - be more specific
# Example: Change "handles frontend" to "Next.js 15 components and React 19 patterns"
```

### Coordination Conflicts
```bash
# Clear domain boundaries needed
# Each agent should have distinct, non-overlapping responsibilities
```

---

## 🎓 Teaching Preparation

**Video Topic**: "Sub-Agent Team Setup" (10 minutes)

**Teaching Points**:
1. Why 4 core agents cover all development needs
2. How to create effective agent specializations  
3. Coordination patterns between agents
4. Common mistakes in agent design

**Key Takeaway**: "Specialized agents work better than generic ones - each should have clear expertise and boundaries."

---

## ➡️ Next Sprint

**Preparation for Sprint 2**:
- [ ] Sub-agent team validated and working
- [ ] Pattern #1 documented in your catalog
- [ ] Any agent prompt refinements completed
- [ ] Ready to build Next.js 15 foundation with agent coordination

**Sprint 2 Preview**: Building Next.js 15 foundation + parallel development setup with your new agent team.

---

**Sprint 1 Complete! Move to [Sprint 2](./day1-sprint2-foundation.md) ✅**
