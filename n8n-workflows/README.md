# n8n + Claude Code Integration

This setup allows you to trigger Claude Code execution via n8n workflows using webhooks.

## Quick Start

### 1. Start n8n

```bash
cd /home/user/tars-persona-system/n8n-workflows
./start-n8n.sh
```

n8n will start on http://localhost:5678

### 2. Import the Workflow

1. Open http://localhost:5678 in your browser
2. Create an account (first time only)
3. Click "Add workflow"
4. Click the "..." menu → "Import from File"
5. Select `claude-code-executor.json`
6. Click "Save" and then "Activate"

### 3. Test the Webhook

The workflow exposes a webhook at:
```
POST http://localhost:5678/webhook/claude-execute
```

**Test with curl:**
```bash
# Simple version check
curl -X POST http://localhost:5678/webhook/claude-execute \
  -H "Content-Type: application/json" \
  -d '{}'

# Execute Claude with a specific prompt
curl -X POST http://localhost:5678/webhook/claude-execute \
  -H "Content-Type: application/json" \
  -d '{
    "command": "claude --help",
    "workdir": "/home/user/tars-persona-system"
  }'
```

## Workflow Structure

The workflow has 3 nodes:

1. **Webhook Trigger** - Receives POST requests
2. **Execute Claude Code** - Runs Claude commands
3. **Respond to Webhook** - Returns results

### Input Parameters

Send JSON in the POST body:

```json
{
  "command": "claude --version",
  "workdir": "/path/to/working/directory"
}
```

- `command` (optional): Command to execute. Default: `claude --version`
- `workdir` (optional): Working directory. Default: `/home/user/tars-persona-system`

### Response Format

```json
{
  "status": "success",
  "output": "stdout output here",
  "error": "stderr output here",
  "exitCode": 0
}
```

## Advanced Examples

### Execute Claude with Context File

```bash
curl -X POST http://localhost:5678/webhook/claude-execute \
  -H "Content-Type: application/json" \
  -d '{
    "command": "echo '\''What is Python?'\'' | claude",
    "workdir": "/home/user/tars-persona-system/examples/research-agent"
  }'
```

### Run Claude in Different Agent Modes

```bash
# Code agent
curl -X POST http://localhost:5678/webhook/claude-execute \
  -H "Content-Type: application/json" \
  -d '{
    "command": "echo '\''Create a Python hello world'\'' | claude",
    "workdir": "/home/user/tars-persona-system/examples/code-agent"
  }'

# Research agent
curl -X POST http://localhost:5678/webhook/claude-execute \
  -H "Content-Type: application/json" \
  -d '{
    "command": "echo '\''Research best Python practices'\'' | claude",
    "workdir": "/home/user/tars-persona-system/examples/research-agent"
  }'
```

## SSH Setup (Optional)

If you want n8n to SSH to a remote box instead of executing locally:

### Install SSH Server

```bash
apt-get update
apt-get install openssh-server
service ssh start
```

### Generate SSH Key for n8n

```bash
ssh-keygen -t ed25519 -f ~/.ssh/n8n_key -N ""
cat ~/.ssh/n8n_key.pub >> ~/.ssh/authorized_keys
```

### Configure n8n SSH Node

1. In n8n, use the "SSH" node instead of "Execute Command"
2. Add credentials:
   - Host: localhost (or remote IP)
   - Port: 22
   - Username: root (or your user)
   - Private Key: Contents of ~/.ssh/n8n_key

## Workflow Files

- `claude-code-executor.json` - Basic webhook → execute → respond
- `start-n8n.sh` - Helper script to start n8n server

## Troubleshooting

### n8n won't start
```bash
# Check if port 5678 is in use
lsof -i :5678

# Kill existing process if needed
pkill -f n8n
```

### Claude not found
```bash
# Verify Claude Code is installed
which claude
claude --version

# Add to PATH if needed
export PATH="/opt/node22/bin:$PATH"
```

### Webhook not responding
1. Make sure workflow is "Active" (toggle in top right)
2. Check n8n logs for errors
3. Verify webhook URL in n8n UI

## Next Steps

### Create Custom Workflows

1. **Scheduled Claude Tasks**
   - Add "Schedule Trigger" node
   - Run Claude Code daily/weekly
   - Save results to file/database

2. **Email → Claude → Email**
   - Email Trigger receives questions
   - Claude processes them
   - Send email with answer

3. **Slack Bot**
   - Slack Trigger
   - Execute Claude
   - Post response back to Slack

4. **Multi-Agent Pipeline**
   - Research agent → findings.md
   - Code agent reads findings.md → code
   - Review agent checks code → report

### Integration Ideas

- **GitHub**: Auto-review PRs with Claude
- **Discord/Slack**: AI assistant bot
- **Cron Jobs**: Regular maintenance tasks
- **API Gateway**: Expose Claude as REST API
- **Data Processing**: Batch analysis with Claude

## Security Notes

⚠️ **Important**: This setup allows command execution via HTTP!

For production:
1. Add authentication to webhook
2. Use HTTPS
3. Validate input commands
4. Run n8n behind a firewall
5. Use environment variables for secrets

## Documentation

- n8n: https://docs.n8n.io
- Claude Code: https://docs.anthropic.com/claude/docs/claude-code
- Webhook Testing: https://webhook.site

---

*Setup created: 2026-01-02*
