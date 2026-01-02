# AI Agents Deep Dive

**Turning AI Into Your Personal Team of Specialists**

AI agents are specialized AI instances that work on specific tasks while you focus on something else. Think of them as delegating work to team members with specific expertise.

## What Are AI Agents?

**Chuck's explanation:**
> "Agents are like having a team working for you. You're not just chatting with one AI anymore - you've got multiple AI workers, each with a specific job."

**Simple definition:** An agent is an AI with:
- A specific task or role
- Its own context and instructions
- The ability to work autonomously
- Results that feed back into your main workflow

## Why Use Agents?

### The Power of Delegation

**Instead of this (single AI doing everything):**
```
You → AI → Research + Write + Debug + Test + Deploy
         ↓
       Overwhelmed, generic results
```

**Do this (specialized agents):**
```
You → Research Agent → Deep research with sources
    → Writing Agent → Polished content
    → Code Agent → Clean, tested code
    → Review Agent → Quality checks
         ↓
    Better results, faster
```

### Real Benefits

**🎯 Specialization**
- Each agent is tuned for one job
- Better results than one AI doing everything
- Clear separation of concerns

**⚡ Parallel Work**
- Multiple agents running simultaneously
- 5 agents = 5x the throughput
- Work on different parts of a project at once

**📁 Context Isolation**
- Each agent has its own context file
- No context pollution
- Clean, focused conversations

## Agent Types & Use Cases

### 1. Research Agents

**Purpose:** Deep dive research with citations

**Example setup:**
```bash
mkdir research-project
cd research-project

# Create research agent context
cat > claude.md << 'EOF'
# Research Agent

## Role
Deep research specialist focusing on accuracy and citations

## Task
Research: History and evolution of terminal-based development

## Instructions
- Find authoritative sources
- Cite all facts
- Organize chronologically
- Include key milestones
- Flag controversial claims

## Output Format
Markdown with inline citations
EOF

# Launch Claude
claude
# Ask: "Begin research on assigned topic"
```

**Best for:**
- Academic research
- Market analysis
- Competitive research
- Technical documentation review

### 2. Writing Agents

**Purpose:** Content creation with consistent style

**Example:**
```markdown
# Writing Agent - Blog Posts

## Role
Professional tech blogger specializing in tutorials

## Style Guidelines
- Conversational but professional
- Use analogies for complex topics
- Include code examples
- Assume intermediate skill level
- Active voice, short paragraphs

## Current Project
Blog series on Docker containerization

## Output
Complete blog post in markdown format
```

**Best for:**
- Blog posts
- Documentation
- Email campaigns
- Social media content

### 3. Code Agents

**Purpose:** Development tasks with specific requirements

**Example:**
```markdown
# Code Agent - Python API

## Role
Python backend developer

## Stack
- Python 3.11
- FastAPI framework
- PostgreSQL database
- pytest for testing

## Standards
- Type hints required
- Docstrings for all functions
- 80% test coverage minimum
- Follow PEP 8

## Current Task
Build REST API for user authentication
```

**Best for:**
- Feature development
- Refactoring
- Test writing
- Code review

### 4. Analysis Agents

**Purpose:** Review and critique work

**Example:**
```markdown
# Analysis Agent - Security Review

## Role
Security analyst and code reviewer

## Focus Areas
- OWASP Top 10 vulnerabilities
- Authentication flaws
- Data validation
- Dependency vulnerabilities
- Configuration issues

## Output
Detailed security report with:
- Severity ratings
- Proof of concept
- Remediation steps
```

**Best for:**
- Security audits
- Code review
- Performance analysis
- Architecture review

### 5. Automation Agents

**Purpose:** Repetitive tasks and workflows

**Example:**
```markdown
# Automation Agent - Daily Reports

## Role
Data processing and reporting automation

## Task
Generate daily status reports from:
- Git commits
- CI/CD pipeline results
- Issue tracker updates
- Team activity logs

## Schedule
Run daily at 9 AM

## Output
Formatted markdown report in reports/daily/
```

**Best for:**
- Report generation
- Data processing
- File organization
- Scheduled tasks

## Setting Up Agents

### Method 1: Directory-Based Agents

**Organize by project folders:**
```
my-project/
├── research/
│   └── claude.md       (Research agent)
├── writing/
│   └── claude.md       (Writing agent)
├── code/
│   └── claude.md       (Code agent)
└── review/
    └── claude.md       (Review agent)
```

**Usage:**
```bash
# Start research
cd my-project/research
claude

# In another terminal, start writing
cd my-project/writing
claude

# In another terminal, start coding
cd my-project/code
claude
```

### Method 2: Tool-Based Specialization

**Use different AI tools for different roles:**
```
project/
├── gemini.md          (Quick research, brainstorming)
├── claude.md          (Complex coding, refactoring)
├── agents.md          (Analysis, review)
└── opencode.md        (Experimental features)
```

**Why this works:**
- Each tool has strengths
- Natural specialization
- Easy to switch contexts
- All share the same file system

### Method 3: Named Context Files

**Advanced: Multiple contexts per tool:**
```bash
# Research mode
claude --context research.md

# Coding mode
claude --context development.md

# Review mode
claude --context review.md
```

## Agent Workflows

### Parallel Research Workflow

**Scenario:** Research multiple topics simultaneously

**Setup:**
```bash
# Terminal 1: Historical research
cd project/history
cat > claude.md << 'EOF'
Research the history of AI in terminals (1970s-present)
EOF
claude

# Terminal 2: Technical research
cd project/technical
cat > claude.md << 'EOF'
Research current terminal AI technologies and APIs
EOF
claude

# Terminal 3: Compile results
cd project
gemini
# Ask: "Combine research from history/ and technical/ folders"
```

**Result:** 3x faster research with specialized focuses

### Sequential Development Workflow

**Scenario:** Plan → Code → Test → Review

**Agent 1 - Planning:**
```markdown
# Planning Agent
Design the architecture for a todo app with user auth
Output: architecture.md with detailed plan
```

**Agent 2 - Development:**
```markdown
# Development Agent
Implement the plan in architecture.md
Use: Python, FastAPI, SQLite
Output: Working code in src/
```

**Agent 3 - Testing:**
```markdown
# Testing Agent
Write comprehensive tests for src/
Target: 90% coverage
Output: Tests in tests/
```

**Agent 4 - Review:**
```markdown
# Review Agent
Review all code in src/ and tests/
Check: Security, performance, best practices
Output: review-report.md
```

### Content Creation Pipeline

**Scenario:** Research → Outline → Draft → Edit → Publish

```
research-agent/
  └─> outputs to research.md

outline-agent/
  └─> reads research.md
  └─> outputs to outline.md

writing-agent/
  └─> reads outline.md
  └─> outputs to draft.md

editing-agent/
  └─> reads draft.md
  └─> outputs to final.md

publishing-agent/
  └─> reads final.md
  └─> posts to blog/social
```

## Agent Communication

### Sharing Data Between Agents

**Method 1: Shared files**
```
project/
├── shared/
│   ├── data.json
│   ├── findings.md
│   └── decisions.md
├── agent-1/
│   └── claude.md (writes to shared/)
└── agent-2/
    └── claude.md (reads from shared/)
```

**Method 2: Context file references**
```markdown
# Agent B Context

## Input Sources
Read and incorporate:
- ../agent-a/output.md
- ../agent-c/results.json

## Dependencies
Wait for agent-a to complete before processing
```

**Method 3: Report files**
```bash
# Agent A generates report
echo "Research complete: 45 sources found" > status.txt

# Agent B checks status
cat status.txt
# Proceeds if complete
```

## Advanced Agent Patterns

### The Review Loop

**Pattern:** Agent creates → Different agent reviews → Original revises

```
Writer Agent → Creates draft.md
              ↓
Review Agent → Analyzes draft.md → Creates feedback.md
              ↓
Writer Agent → Reads feedback.md → Creates draft-v2.md
              ↓
Review Agent → Approves or repeats
```

**Implementation:**
```bash
# Round 1
cd writing/ && claude
# Creates: draft.md

cd ../review/ && claude
# Reads: draft.md
# Creates: feedback.md

cd ../writing/ && claude
# Reads: feedback.md
# Updates: draft.md
```

### The Assembly Line

**Pattern:** Sequential processing by specialized agents

```
Raw Data → Agent 1 (Clean) → Agent 2 (Analyze) →
Agent 3 (Visualize) → Agent 4 (Report) → Final Output
```

**Each agent:**
1. Reads from previous stage
2. Performs its specialty
3. Writes output for next stage
4. Updates status file

### The Swarm

**Pattern:** Multiple agents attack same problem from different angles

```
Problem: "Why is the app slow?"

Agent 1: Database query analysis
Agent 2: Frontend performance profiling
Agent 3: API endpoint timing
Agent 4: Resource usage monitoring
Agent 5: Code complexity analysis

→ Compile all findings → Comprehensive answer
```

## Practical Examples

### Example 1: Multi-Language Documentation

**Goal:** Generate API docs in 5 languages

**Setup:**
```bash
for lang in en es fr de ja; do
  mkdir -p docs/$lang
  cat > docs/$lang/claude.md << EOF
Translate API documentation to $lang
Maintain technical accuracy
Use native terminology
EOF
done

# Run all in parallel (5 terminals or background processes)
```

**Result:** Complete multilingual docs in parallel

### Example 2: Code Migration

**Goal:** Convert React class components to hooks

**Agent 1: Analysis**
```markdown
Find all class components
Create migration priority list
Identify complex cases
```

**Agent 2: Simple Migrations**
```markdown
Convert simple class components
Run tests after each
```

**Agent 3: Complex Migrations**
```markdown
Handle lifecycle methods
Complex state management
```

**Agent 4: Testing**
```markdown
Verify all converted components
Check for regressions
```

### Example 3: Security Audit

**Agent 1: Dependency Scan**
```markdown
Check npm audit
Identify CVEs
Prioritize by severity
```

**Agent 2: Code Analysis**
```markdown
Scan for SQL injection
XSS vulnerabilities
Auth issues
```

**Agent 3: Infrastructure Review**
```markdown
Check configs
Environment variables
Access controls
```

**Agent 4: Report Compilation**
```markdown
Combine all findings
Create remediation plan
Prioritize fixes
```

## Tips & Best Practices

### ✅ DO

**Clear Role Definition**
```markdown
# Good
Role: Python backend developer specializing in FastAPI

# Bad
Role: Help with coding
```

**Specific Instructions**
```markdown
# Good
- Use type hints
- Write docstrings
- Follow PEP 8
- Include unit tests

# Bad
- Write good code
```

**Output Requirements**
```markdown
# Good
Output: JSON file at outputs/results.json with schema:
{
  "findings": [],
  "confidence": 0-100,
  "sources": []
}

# Bad
Output: Save the results
```

### ❌ DON'T

**Don't overlap responsibilities**
```markdown
# Bad: Two agents doing the same thing
Agent 1: Write Python code
Agent 2: Write Python code

# Good: Clear separation
Agent 1: Write Python backend
Agent 2: Write Python tests
```

**Don't make agents too general**
```markdown
# Bad
Agent: Do whatever is needed

# Good
Agent: Write unit tests with pytest, target 80% coverage
```

**Don't skip context**
```markdown
# Bad
Claude, please help with the project

# Good
# Email Campaign Agent
Generate marketing emails for SaaS product launch
Target: B2B tech decision makers
Tone: Professional but approachable
Length: 150-200 words
```

## Monitoring Agents

### Track Progress

**Status files:**
```bash
# Each agent updates status
echo "Research: 80% complete" > research/status.txt
echo "Writing: Draft ready" > writing/status.txt
echo "Review: In progress" > review/status.txt

# Monitor all
watch 'cat */status.txt'
```

**Log files:**
```bash
# Agents log their actions
echo "[$(date)] Started analysis" >> agent.log
echo "[$(date)] Found 5 issues" >> agent.log
echo "[$(date)] Complete" >> agent.log
```

### Coordinate Timing

**For sequential workflows:**
```bash
# Agent B waits for Agent A
while [ ! -f ../agent-a/complete.flag ]; do
  sleep 5
done

# Now proceed with Agent B tasks
```

## Tools for Agent Management

### Tmux for Multiple Agents

**Run agents in split panes:**
```bash
# Create tmux session
tmux new -s agents

# Split into 4 panes
Ctrl+B "  # Horizontal split
Ctrl+B %  # Vertical split

# Launch different agents in each pane
# Pane 1: cd research && claude
# Pane 2: cd writing && claude
# Pane 3: cd review && claude
# Pane 4: monitor watch 'cat */status.txt'
```

### Screen for Background Agents

```bash
# Start background agents
screen -dmS research bash -c "cd research && claude"
screen -dmS writing bash -c "cd writing && claude"

# List running agents
screen -ls

# Attach to an agent
screen -r research
```

## When NOT to Use Agents

**Agents add complexity. Don't use them when:**

❌ Simple one-off tasks
- "What's the syntax for Python f-strings?"
- Just use regular AI chat

❌ Highly interactive work
- Debugging a specific issue
- Agents work best autonomously

❌ Tasks requiring constant human input
- Creative brainstorming
- Exploratory discussions

❌ Very small projects
- Single file scripts
- Quick experiments

**Use agents when:**
✅ Complex multi-step projects
✅ Parallel workstreams
✅ Specialized expertise needed
✅ Repetitive workflows
✅ Need to scale your work

## Next Steps

**Start simple:**
1. Create two agents for your current project
2. One for research, one for implementation
3. Let them run in parallel
4. Combine their outputs

**Then level up:**
- Add review agents
- Create agent templates
- Build standard workflows
- Automate agent launches

---

## Related Guides

- [Context Files Explained](07-context-files.md) - Master agent context
- [Multi-Tool Workflow](08-multi-tool-workflow.md) - Combine different AI tools
- [Development Workflows](12-development-workflows.md) - Coding with agents

---

[← Back to README](../README.md)
