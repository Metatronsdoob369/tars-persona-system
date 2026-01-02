#!/bin/bash
# Test the n8n Claude Code webhook

N8N_URL="http://localhost:5678"
WEBHOOK_PATH="/webhook/claude-execute"
FULL_URL="${N8N_URL}${WEBHOOK_PATH}"

echo "======================================================================"
echo "n8n Claude Code Webhook - Test Script"
echo "======================================================================"
echo ""
echo "Webhook URL: $FULL_URL"
echo ""

# Check if n8n is running
if ! curl -s "$N8N_URL" > /dev/null 2>&1; then
    echo "❌ n8n is not running on $N8N_URL"
    echo ""
    echo "Start n8n with:"
    echo "  ./start-n8n.sh"
    echo ""
    exit 1
fi

echo "✅ n8n is running"
echo ""

# Test 1: Simple version check
echo "Test 1: Claude version check"
echo "------------------------------------"
RESPONSE=$(curl -s -X POST "$FULL_URL" \
  -H "Content-Type: application/json" \
  -d '{}')

if [ $? -eq 0 ]; then
    echo "Response:"
    echo "$RESPONSE" | python3 -m json.tool 2>/dev/null || echo "$RESPONSE"
else
    echo "❌ Request failed"
fi
echo ""

# Test 2: Claude help
echo "Test 2: Claude help command"
echo "------------------------------------"
RESPONSE=$(curl -s -X POST "$FULL_URL" \
  -H "Content-Type: application/json" \
  -d '{
    "command": "claude --help",
    "workdir": "/home/user/tars-persona-system"
  }')

if [ $? -eq 0 ]; then
    echo "Response:"
    echo "$RESPONSE" | python3 -m json.tool 2>/dev/null || echo "$RESPONSE"
else
    echo "❌ Request failed"
fi
echo ""

# Test 3: Execute in specific agent directory
echo "Test 3: Execute in code-agent directory"
echo "------------------------------------"
RESPONSE=$(curl -s -X POST "$FULL_URL" \
  -H "Content-Type: application/json" \
  -d '{
    "command": "ls -la",
    "workdir": "/home/user/tars-persona-system/examples/code-agent"
  }')

if [ $? -eq 0 ]; then
    echo "Response:"
    echo "$RESPONSE" | python3 -m json.tool 2>/dev/null || echo "$RESPONSE"
else
    echo "❌ Request failed"
fi
echo ""

echo "======================================================================"
echo "Tests Complete"
echo "======================================================================"
echo ""
echo "Next steps:"
echo "  1. Open http://localhost:5678 to see n8n UI"
echo "  2. Import claude-code-executor.json workflow"
echo "  3. Activate the workflow"
echo "  4. Customize the workflow as needed"
echo ""
