# Output Styles & Customization

**Make AI Work YOUR Way**

One of the biggest advantages of terminal AI is customization. You can make AI output exactly what you need, in the format you want, with the style that fits your workflow.

## The Problem with Browser AI

**Chuck's frustration:**
> "ChatGPT gives you this giant wall of text. Code in a box you have to copy. Explanations you don't need. You just wanted a single command!"

**Browser AI limitations:**
- Fixed output format
- Can't control verbosity
- Stuck with their interface
- No automation possible
- One-size-fits-all responses

## Terminal AI: Total Control

**What you can customize:**
- 📝 Output format (JSON, markdown, plain text, code only)
- 🎨 Output style (verbose, concise, technical, beginner-friendly)
- 📊 Data structure (how information is organized)
- 🔧 Tool behavior (how AI approaches tasks)
- 🤖 Persona (how AI communicates)

## Output Format Control

### Markdown Output

**Request specific markdown structure:**
```markdown
Output format requirements:
- Use h2 headers for main sections
- Code blocks with language tags
- Bullet points for lists
- Bold for emphasis only
- No emoji
```

**Example request:**
```bash
claude

> Create a guide for Python virtual environments.
> Output as markdown with:
> - Overview section
> - Step-by-step commands in code blocks
> - Common issues section
> - No explanatory text between commands
```

**Result:**
```markdown
## Overview
Python virtual environments isolate project dependencies

## Setup
...bash
python -m venv myenv
source myenv/bin/activate  # Linux/Mac
myenv\Scripts\activate     # Windows
...

## Common Issues
- venv module not found → Install python3-venv
- Activation fails → Check file permissions
```

### JSON Output

**Perfect for automation and scripting:**
```bash
gemini

> Analyze this code for security issues.
> Output as JSON with this schema:
> {
>   "issues": [
>     {
>       "severity": "high|medium|low",
>       "type": "vulnerability type",
>       "line": 42,
>       "description": "what's wrong",
>       "fix": "how to fix it"
>     }
>   ],
>   "summary": "overall assessment"
> }
```

**Use in scripts:**
```bash
# Get JSON output
gemini "Analyze security in app.py, output JSON" > security.json

# Process with jq
jq '.issues[] | select(.severity=="high")' security.json

# Count issues
jq '.issues | length' security.json
```

### Plain Text / Code Only

**Get just the code, no explanation:**
```bash
claude

> Python function to parse CSV files
> Output: code only, no explanations
```

**Result:**
```python
import csv

def parse_csv(filepath):
    with open(filepath, 'r') as f:
        reader = csv.DictReader(f)
        return list(reader)
```

**No markdown, no "here's a function...", just code.**

### Table Output

**Request data as tables:**
```bash
gemini

> Compare Python web frameworks
> Output as markdown table
> Columns: Framework, Performance, Learning Curve, Use Case
```

**Result:**
```markdown
| Framework | Performance | Learning Curve | Use Case |
|-----------|-------------|----------------|----------|
| Flask | Medium | Easy | Small APIs, prototypes |
| Django | Medium | Moderate | Full-stack apps |
| FastAPI | High | Easy | Modern APIs |
```

## Style Customization

### Verbosity Control

**Concise mode:**
```markdown
# In your context file (claude.md)

## Communication Style
- Maximum conciseness
- No pleasantries or filler
- Answer only what was asked
- Code > explanations
- Assume expert user
```

**Verbose mode:**
```markdown
## Communication Style
- Detailed explanations
- Include context and rationale
- Step-by-step breakdowns
- Explain trade-offs
- Assume beginner user
```

**Example difference:**

**Concise request:**
```
> How to reverse a list in Python?
```
**Concise response:**
```python
my_list.reverse()  # In-place
my_list[::-1]      # New list
```

**Verbose response:**
```
There are two main approaches to reversing a list in Python:

1. In-place reversal with .reverse():
   - Modifies the original list
   - Returns None
   - Most memory efficient

2. Slice notation [::-1]:
   - Creates a new reversed list
   - Original list unchanged
   - More Pythonic

Use .reverse() when you don't need the original.
Use [::-1] when you need both versions.
```

### Technical Level

**Adjust to your expertise:**

**Expert mode:**
```markdown
## Audience Level
- Expert developer
- 10+ years experience
- Prefer technical terms
- Skip basic concepts
- Focus on edge cases and optimization
```

**Beginner mode:**
```markdown
## Audience Level
- Learning to code
- Explain everything
- Use analogies
- Define technical terms
- Step-by-step guidance
```

**Example:**

**Expert request:** "Optimize this database query"
**Expert response:**
```sql
-- Add composite index on (user_id, created_at)
CREATE INDEX idx_user_created ON events(user_id, created_at DESC);

-- Use covering index to avoid table lookup
CREATE INDEX idx_covering ON events(user_id, created_at, event_type)
  INCLUDE (data);
```

**Beginner request:** "Make this database query faster"
**Beginner response:**
```sql
-- A database index is like a book's index -
-- it helps find data faster

-- This index helps when searching by user_id and created_at
CREATE INDEX idx_user_created ON events(user_id, created_at DESC);

-- How it helps:
-- - Without index: Database scans every row
-- - With index: Database jumps directly to matching rows
-- - Can make queries 100x faster
```

### Communication Tone

**Professional:**
```markdown
## Tone
- Business appropriate
- Formal language
- Third person when applicable
- No slang or colloquialisms
```

**Casual:**
```markdown
## Tone
- Conversational
- Second person (you/your)
- Analogies and examples
- Like explaining to a friend
```

**Direct/Blunt:**
```markdown
## Tone
- Cut to the chase
- No sugar coating
- Point out bad practices
- Efficiency over politeness
```

## Persona Customization

### Role-Based Personas

**Code Reviewer:**
```markdown
# Code Reviewer Persona

## Role
Senior engineer conducting code review

## Behavior
- Point out bugs and issues
- Suggest improvements
- Highlight security concerns
- Note best practice violations
- Rate code quality

## Output Format
- Issue list with severity
- Specific line references
- Recommended fixes
```

**Pair Programmer:**
```markdown
# Pair Programmer Persona

## Role
Collaborative coding partner

## Behavior
- Think out loud
- Discuss trade-offs
- Ask clarifying questions
- Suggest alternatives
- Explain reasoning

## Communication
- Conversational
- "We could..." instead of "You should..."
- Explore options together
```

**Technical Writer:**
```markdown
# Technical Writer Persona

## Role
Documentation specialist

## Behavior
- Write clear documentation
- Use consistent terminology
- Include examples
- Structure for readability
- Target specified audience

## Output
- Markdown documentation
- Code examples with explanations
- Diagrams when helpful (ASCII)
```

### Specialist Personas

**Security Expert:**
```markdown
# Security Specialist

Think like an attacker
Focus: OWASP Top 10, CVEs, threat modeling
Output: Vulnerability reports with PoC
Assume: Everything is untrusted
```

**Performance Engineer:**
```markdown
# Performance Engineer

Focus: Speed and efficiency
Analyze: Time/space complexity, bottlenecks
Output: Benchmarks, optimization suggestions
Assume: Performance matters most
```

**DevOps Engineer:**
```markdown
# DevOps Engineer

Focus: Automation, reliability, scalability
Tools: Docker, Kubernetes, CI/CD
Output: Infrastructure as code
Assume: Production-ready requirements
```

## Custom Output Templates

### Report Template

**Define standard report format:**
```markdown
# Report Template

All analysis outputs must follow this structure:

## Executive Summary
- One paragraph overview
- Key findings (3-5 bullets)

## Detailed Analysis
- Findings organized by category
- Evidence for each finding
- Severity ratings

## Recommendations
- Prioritized action items
- Implementation steps
- Expected impact

## Appendix
- Raw data
- Methodology
- References
```

**Use it:**
```bash
> Analyze this codebase
> Use the report template defined in context
```

### Code Documentation Template

```markdown
# Code Documentation Template

For every function/class documented:

## Purpose
Brief description (1 sentence)

## Parameters
- name (type): description

## Returns
type: description

## Example
...python
# Working code example
...

## Notes
- Edge cases
- Performance considerations
- Related functions
```

### API Documentation Template

```markdown
# API Endpoint Documentation Template

## Endpoint
- Method: POST/GET/etc
- Path: /api/v1/resource
- Auth: Required/Optional

## Request
...json
{
  "field": "type - description"
}
...

## Response
...json
{
  "field": "type - description"
}
...

## Errors
- 400: Bad Request - Invalid input
- 401: Unauthorized - Missing/invalid auth
- 404: Not Found - Resource doesn't exist

## Example
...bash
curl -X POST example...
...
```

## Tool-Specific Customization

### Gemini CLI Customization

**Config file approach:**
```bash
# Create .gemini-config in project root
cat > .gemini-config << 'EOF'
{
  "style": "concise",
  "format": "markdown",
  "code_only": false,
  "explain_reasoning": true
}
EOF
```

**In context file:**
```markdown
# Gemini Context

## Output Preferences
- Format: Markdown with code blocks
- Style: Technical and concise
- Code: Include comments
- Explanations: Only for complex logic
```

### Claude Code Customization

**Context file (`claude.md`):**
```markdown
# Project Context

## Claude Behavior Preferences

### Output Format
- Code files: No markdown, just code
- Explanations: Concise comments in code
- File operations: Show what you're doing
- Errors: Full stack traces

### Coding Style
- Language: Python 3.11
- Style guide: PEP 8
- Type hints: Required
- Docstrings: Google style
- Imports: Grouped and sorted

### Communication
- Be direct and concise
- No apologies or hedging
- Ask for clarification when ambiguous
- Suggest better approaches when applicable
```

### Codex Customization

**agents.md configuration:**
```markdown
# Codex Agent Configuration

## Analysis Mode
When analyzing code:
- Identify patterns and anti-patterns
- Rate code quality (1-10)
- Suggest refactoring opportunities
- Highlight security issues

## Output Structure
1. Quick Summary (2-3 sentences)
2. Detailed Findings (categorized)
3. Priority Recommendations
4. Code Examples

## Depth
- Deep analysis by default
- Consider edge cases
- Think about maintainability
- Flag technical debt
```

## Advanced Customization

### Conditional Formatting

**In context file:**
```markdown
## Output Rules

### For bug reports:
- Use JSON format
- Include severity, type, location, fix

### For feature requests:
- Use markdown
- Include use case, implementation approach, testing strategy

### For code review:
- Inline comments
- Severity labels (🔴 critical, 🟡 warning, 🟢 suggestion)

### For documentation:
- Markdown with examples
- Beginner-friendly language
- Links to references
```

### Multi-Format Output

**Request multiple formats:**
```bash
> Create a user authentication system
>
> Output three files:
> 1. auth.py - Implementation (code only, well commented)
> 2. auth_docs.md - Documentation (markdown)
> 3. auth_tests.py - Test suite (pytest)
```

### Structured Data Output

**For parsing and automation:**
```bash
> Analyze all Python files in src/
> Output as JSON array:
> [
>   {
>     "file": "path/to/file.py",
>     "lines": 120,
>     "functions": 8,
>     "complexity": "high|medium|low",
>     "issues": ["list of issues"],
>     "quality_score": 85
>   }
> ]
```

**Process it:**
```bash
# Get output
claude "analyze src/, output JSON" > analysis.json

# Find complex files
jq '.[] | select(.complexity=="high") | .file' analysis.json

# Average quality score
jq '[.[].quality_score] | add / length' analysis.json
```

## Workflow-Specific Customization

### Git Commit Messages

**Standardize format:**
```markdown
## Git Commit Message Format

type(scope): brief description

Detailed explanation:
- What changed
- Why it changed
- Impact of change

Types: feat, fix, docs, style, refactor, test, chore
Max length: 72 characters for first line
```

**Use it:**
```bash
> Generate commit message for these changes:
> - Added user authentication
> - Fixed login bug
> - Updated documentation
```

**Output:**
```
feat(auth): add user authentication system

- Implemented JWT-based authentication
- Added login, logout, and session management
- Fixed bug causing duplicate login attempts
- Updated API documentation

Closes #123
```

### Code Review Comments

**Template:**
```markdown
## Code Review Comment Format

**[SEVERITY]** File:line

Issue: Brief description

Why: Explanation of the problem

Fix:
...language
// Suggested code
...

Impact: What happens if not fixed
```

### Documentation Style

**For technical docs:**
```markdown
## Technical Documentation Style

Structure:
1. Brief overview
2. Quick start example
3. Detailed reference
4. Advanced topics
5. Troubleshooting

Code examples:
- Working, complete examples
- Comments explaining key parts
- Show common use cases

Language:
- Active voice
- Present tense
- Second person (you)
- Define terms on first use
```

## Automation with Custom Formats

### Shell Script Integration

**Get structured output for scripts:**
```bash
#!/bin/bash

# Get list of security issues as JSON
issues=$(claude "Security audit on $1, output JSON array of issues")

# Extract high severity issues
high_priority=$(echo "$issues" | jq '[.[] | select(.severity=="high")]')

# If any high priority issues, fail the build
count=$(echo "$high_priority" | jq 'length')
if [ "$count" -gt 0 ]; then
  echo "Found $count high severity issues:"
  echo "$high_priority" | jq -r '.[] | "- \(.description)"'
  exit 1
fi
```

### Make Integration

```makefile
# Makefile

.PHONY: review
review:
    @claude "Review changes in last commit, output markdown" > review.md
    @cat review.md

.PHONY: document
document:
    @claude "Generate API docs from code, output markdown" > API.md

.PHONY: test-plan
test-plan:
    @claude "Create test plan for new features, output markdown checklist"
```

### Git Hooks

```bash
# .git/hooks/pre-commit

#!/bin/bash

# Get AI review of staged changes
review=$(claude "Review staged changes, output JSON with issues")

# Check for critical issues
critical=$(echo "$review" | jq '[.issues[] | select(.severity=="critical")] | length')

if [ "$critical" -gt 0 ]; then
  echo "❌ Critical issues found:"
  echo "$review" | jq -r '.issues[] | select(.severity=="critical") | "- \(.description)"'
  echo ""
  echo "Fix these issues before committing."
  exit 1
fi

echo "✅ Code review passed"
```

## Tips & Best Practices

### ✅ DO

**Be specific about format:**
```markdown
# Good
Output as JSON array of objects with fields: name, value, description

# Bad
Give me the data
```

**Define structure clearly:**
```markdown
# Good
Use markdown with:
- H2 for main sections
- Code blocks with language tags
- Bullet lists for items
- No emoji

# Bad
Make it look nice
```

**Create reusable templates:**
```markdown
# Good - Store in context file
## Bug Report Template
[detailed template here]

# Bad - Repeat instructions every time
```

### ❌ DON'T

**Don't be vague:**
```markdown
# Bad
Make the output better

# Good
Output as markdown table with columns: Feature, Status, Notes
```

**Don't over-customize:**
```markdown
# Bad - Too rigid
- Use exactly 3 sentences
- Start each sentence with a verb
- End with exactly 2 examples
- Use the word "optimize" at least once

# Good - Flexible but clear
- Brief explanation (2-4 sentences)
- Include examples
- Focus on optimization
```

**Don't forget context:**
```markdown
# Bad
[No context file, specify format every time]

# Good
[Context file has standard formats, reference them]
```

## Examples by Use Case

### Quick Scripts

**Context:**
```markdown
When I ask for scripts:
- Output: Code only, no markdown
- Language: Bash unless specified
- Comments: Brief, inline only
- Error handling: Include basic checks
- No explanations outside code
```

**Request:**
```
> Script to backup MySQL database
```

**Output:**
```bash
#!/bin/bash
DB_NAME="${1:-mydb}"
BACKUP_DIR="./backups"
DATE=$(date +%Y%m%d_%H%M%S)

mkdir -p "$BACKUP_DIR"
mysqldump "$DB_NAME" | gzip > "$BACKUP_DIR/${DB_NAME}_${DATE}.sql.gz"
```

### Production Code

**Context:**
```markdown
When writing production code:
- Type hints required (Python)
- Comprehensive docstrings
- Error handling for all edge cases
- Input validation
- Logging for debugging
- No TODOs or placeholder code
```

**Request:**
```
> User registration function
```

**Output:**
```python
import logging
from typing import Optional
from email_validator import validate_email
from werkzeug.security import generate_password_hash

logger = logging.getLogger(__name__)

def register_user(
    username: str,
    email: str,
    password: str
) -> Optional[int]:
    """
    Register a new user in the system.

    Args:
        username: Desired username (3-20 alphanumeric chars)
        email: User's email address
        password: Plain text password (min 8 chars)

    Returns:
        User ID if successful, None if validation fails

    Raises:
        ValueError: If input validation fails
        DatabaseError: If database operation fails
    """
    # Validate username
    if not username or not username.isalnum() or not (3 <= len(username) <= 20):
        raise ValueError("Username must be 3-20 alphanumeric characters")

    # Validate email
    try:
        validate_email(email)
    except Exception as e:
        raise ValueError(f"Invalid email: {e}")

    # Validate password
    if len(password) < 8:
        raise ValueError("Password must be at least 8 characters")

    # Hash password
    password_hash = generate_password_hash(password)

    # Database insertion (example)
    try:
        user_id = db.insert_user(username, email, password_hash)
        logger.info(f"User registered: {username}")
        return user_id
    except Exception as e:
        logger.error(f"Registration failed for {username}: {e}")
        raise
```

### Learning/Exploration

**Context:**
```markdown
When I'm learning:
- Explain everything
- Use analogies
- Include "why" not just "how"
- Show multiple approaches
- Point out common mistakes
```

**Request:**
```
> How do decorators work in Python?
```

**Output:**
```
Decorators are functions that modify other functions.
Think of it like gift wrapping - the present (function)
stays the same, but you add something around it (wrapper).

[Detailed explanation with examples...]
```

## Saving Your Customizations

### Context File Templates

**Create template library:**
```bash
~/.ai-templates/
├── code-review.md
├── documentation.md
├── quick-script.md
├── production-code.md
└── learning-mode.md
```

**Use templates:**
```bash
# Start new project
mkdir my-project
cd my-project

# Copy appropriate template
cp ~/.ai-templates/production-code.md ./claude.md

# Customize for this project
vim claude.md
```

### Project-Specific Customization

```
project/
├── claude.md           # Overall project context
├── .claude/
│   ├── review.md       # For code review mode
│   ├── docs.md         # For documentation mode
│   └── debug.md        # For debugging mode
```

**Switch modes:**
```bash
# Code review mode
claude --context .claude/review.md

# Documentation mode
claude --context .claude/docs.md
```

## Next Steps

**Start simple:**
1. Add output format preferences to your context file
2. Define your preferred communication style
3. Create one reusable template

**Level up:**
- Build a template library
- Automate with custom formats
- Create role-specific personas
- Integrate with your tools

---

## Related Guides

- [Context Files Explained](07-context-files.md) - Where to put customizations
- [AI Agents Deep Dive](09-agents.md) - Specialized agent customization
- [Command Cheat Sheet](14-cheat-sheet.md) - Quick reference

---

[← Back to README](../README.md)
