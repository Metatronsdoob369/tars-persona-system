# n8n + Claude Code - READY TO USE!

## ✅ Status: INSTALLED AND RUNNING

n8n is now running on your system:
- **URL**: http://localhost:5678
- **Status**: Active (PID: check with `ps aux | grep n8n`)
- **Logs**: `/tmp/n8n.log`

## Quick Access

```bash
# Open n8n in browser
# Navigate to: http://localhost:5678

# Check if running
curl http://localhost:5678

# View logs
tail -f /tmp/n8n.log

# Stop n8n
pkill -f n8n

# Start n8n again
cd /home/user/tars-persona-system/n8n-workflows
./start-n8n.sh
```

## Getting Started (5 Minutes)

### Step 1: Open n8n
1. Open browser to http://localhost:5678
2. Create an account (email + password)
3. You'll see the n8n workflow canvas

### Step 2: Create Your First Workflow

**Option A: Manual Creation (Recommended to learn)**

1. Click "+ Add workflow" or "New workflow"
2. Click the "+" button to add your first node
3. Search for "Webhook" and select it
4. Configure webhook:
   - **HTTP Method**: POST
   - **Path**: `claude-execute`
   - **Response Mode**: "Respond to Webhook"
5. Click "Execute Node" to activate the webhook
6. You'll get a URL like: `http://localhost:5678/webhook-test/claude-execute`

7. Add an "Execute Command" node:
   - Click the "+" after webhook
   - Search for "Execute Command"
   - **Command**: `claude --version`
   - **Working Directory**: `/home/user/tars-persona-system`

8. Add "Respond to Webhook" node:
   - Click "+" after Execute Command
   - Search for "Respond to Webhook"
   - Leave default settings

9. Click "Save" (top right)
10. Click "Activate" toggle (top right)

**Option B: Import Pre-Built Workflow**

1. Download `claude-code-executor.json`
2. In n8n, click "..." menu → "Import from File"
3. Select the JSON file
4. Click "Save" and "Activate"

### Step 3: Test It!

```bash
# Test with curl
curl -X POST http://localhost:5678/webhook/claude-execute \
  -H "Content-Type: application/json" \
  -d '{
    "command": "claude --version"
  }'
```

Or use the test script:
```bash
cd /home/user/tars-persona-system/n8n-workflows
./test-webhook.sh
```

## What You Can Do Now

### 1. Execute Claude Code via HTTP

```bash
# Simple version check
curl -X POST http://localhost:5678/webhook/claude-execute \
  -H "Content-Type: application/json" \
  -d '{"command": "claude --version"}'

# Execute in specific directory
curl -X POST http://localhost:5678/webhook/claude-execute \
  -H "Content-Type: application/json" \
  -d '{
    "command": "ls -la",
    "workdir": "/home/user/tars-persona-system/examples/code-agent"
  }'
```

### 2. Use Different AI Agents

```bash
# Code Agent
curl -X POST http://localhost:5678/webhook/claude-execute \
  -H "Content-Type: application/json" \
  -d '{
    "command": "echo \"Write a Python hello world\" | claude",
    "workdir": "/home/user/tars-persona-system/examples/code-agent"
  }'

# Research Agent
curl -X POST http://localhost:5678/webhook/claude-execute \
  -H "Content-Type: application/json" \
  -d '{
    "command": "echo \"Research Python best practices\" | claude",
    "workdir": "/home/user/tars-persona-system/examples/research-agent"
  }'

# Review Agent
curl -X POST http://localhost:5678/webhook/claude-execute \
  -H "Content-Type: application/json" \
  -d '{
    "command": "echo \"Review the code in ../code-agent\" | claude",
    "workdir": "/home/user/tars-persona-system/examples/review-agent"
  }'
```

### 3. Build Advanced Workflows

#### Scheduled Daily Report
1. Add "Schedule Trigger" node (cron: `0 9 * * *` for 9 AM daily)
2. Execute Command: `claude "Generate daily report"`
3. Save to file or send email

#### GitHub PR Reviewer
1. Webhook receives GitHub PR webhook
2. Execute: `claude "Review this PR: {{$json.pr_url}}"`
3. Post comment back to GitHub

#### Slack Bot
1. Slack Trigger listens for mentions
2. Execute Claude with the question
3. Post response back to Slack

#### Multi-Agent Pipeline
```
Trigger
  → Research Agent (save to research.md)
  → Code Agent (read research.md, write code)
  → Review Agent (check code, save report)
  → Send summary email
```

## Example Workflows Included

### 1. claude-code-executor.json
Basic webhook → execute → respond pattern

**Nodes:**
- Webhook Trigger (POST /webhook/claude-execute)
- Execute Command (runs Claude)
- Respond to Webhook (returns results)

**Usage:**
```bash
curl -X POST http://localhost:5678/webhook/claude-execute \
  -H "Content-Type: application/json" \
  -d '{"command": "claude --help"}'
```

## Advanced Configuration

### Environment Variables

Create `.env` file in n8n directory:
```bash
# n8n Configuration
N8N_PORT=5678
N8N_HOST=0.0.0.0
N8N_PROTOCOL=http

# Security (recommended for production)
N8N_BASIC_AUTH_ACTIVE=true
N8N_BASIC_AUTH_USER=admin
N8N_BASIC_AUTH_PASSWORD=your-secure-password

# Webhook Configuration
WEBHOOK_URL=http://localhost:5678

# Claude Code Configuration
CLAUDE_PATH=/opt/node22/bin/claude
```

### SSL/HTTPS Setup

For production, use nginx or similar:
```nginx
server {
    listen 443 ssl;
    server_name n8n.yourdomain.com;

    ssl_certificate /path/to/cert.pem;
    ssl_certificate_key /path/to/key.pem;

    location / {
        proxy_pass http://localhost:5678;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

### Authentication

Add basic auth to workflows:
1. In webhook node, enable "Authentication"
2. Set username and password
3. Clients must send Authorization header:
   ```bash
   curl -u username:password -X POST ...
   ```

## Troubleshooting

### n8n not starting
```bash
# Check if port is in use
lsof -i :5678

# Kill existing process
pkill -f n8n

# Check logs
tail -f /tmp/n8n.log

# Start fresh
rm -rf ~/.n8n
./start-n8n.sh
```

### Webhook not working
1. Ensure workflow is "Active" (toggle in top right)
2. Check webhook URL in n8n UI
3. Verify command in Execute node
4. Check n8n logs: `tail -f /tmp/n8n.log`

### Claude not found
```bash
# Verify Claude is installed
which claude

# Add to PATH
export PATH="/opt/node22/bin:$PATH"

# Update Execute Command node to use full path
/opt/node22/bin/claude --version
```

### Permission issues
```bash
# Ensure scripts are executable
chmod +x /home/user/tars-persona-system/n8n-workflows/*.sh

# Check file ownership
ls -la /home/user/tars-persona-system/n8n-workflows/
```

## Next Steps

### 1. Explore n8n Nodes
- **HTTP Request** - Call external APIs
- **Code** - Run JavaScript/Python
- **If** - Conditional logic
- **Switch** - Multiple branches
- **Set** - Modify data
- **Function** - Advanced data transformation

### 2. Connect to Other Services
- Gmail (send/receive emails)
- Slack (bot integration)
- GitHub (PR automation)
- Discord (bot commands)
- Google Sheets (data processing)
- Database nodes (store results)

### 3. Build Your TARS System
Based on your repo name, you might want:
- Multiple Claude personas (code, research, review)
- Workflow orchestration
- Task automation
- Integration with external systems

Example TARS workflow:
```
User Request (Webhook)
  → Classifier (determine task type)
  → Switch (route to appropriate agent)
    → Code Agent (writes code)
    → Research Agent (researches topic)
    → Review Agent (reviews output)
  → Combine results
  → Return to user
```

## Files Created

```
/home/user/tars-persona-system/n8n-workflows/
├── README.md                     # Detailed documentation
├── N8N-SETUP.md                  # This file (quick start)
├── start-n8n.sh                  # Start script
├── test-webhook.sh               # Test script
└── claude-code-executor.json     # Workflow template
```

## Resources

- **n8n Documentation**: https://docs.n8n.io
- **n8n Community**: https://community.n8n.io
- **Workflow Templates**: https://n8n.io/workflows
- **Claude Code Docs**: https://docs.anthropic.com/claude/docs/claude-code

---

**Status**: ✅ Ready to use!
**n8n Version**: 2.1.5
**Claude Code Version**: 2.0.59
**Setup Date**: 2026-01-02
