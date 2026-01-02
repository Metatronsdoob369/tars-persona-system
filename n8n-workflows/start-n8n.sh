#!/bin/bash
# Start n8n workflow automation server

# Set n8n environment variables
export N8N_PORT=5678
export N8N_PROTOCOL=http
export N8N_HOST=0.0.0.0
export WEBHOOK_URL=http://localhost:5678

echo "Starting n8n on port 5678..."
echo "Access at: http://localhost:5678"
echo ""
echo "Press Ctrl+C to stop"
echo ""

# Start n8n in the foreground
n8n start
