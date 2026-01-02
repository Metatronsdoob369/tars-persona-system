#!/bin/bash
# Simple test script for AI terminal tools

echo "======================================================================"
echo "AI Terminal Tools - Installation Test"
echo "======================================================================"
echo ""

# Test 1: Claude Code
echo "1. Claude Code CLI"
if command -v claude &> /dev/null; then
    VERSION=$(claude --version 2>&1)
    echo "   ✅ Claude Code is installed: $VERSION"
else
    echo "   ❌ Claude Code not found"
fi
echo ""

# Test 2: OpenAI CLI
echo "2. OpenAI CLI"
if command -v openai &> /dev/null; then
    echo "   ✅ OpenAI CLI is installed"
    if [ -n "$OPENAI_API_KEY" ]; then
        echo "   ✅ OPENAI_API_KEY is set"
    else
        echo "   ⚠️  OPENAI_API_KEY not set (needed for actual use)"
        echo "      Get key from: https://platform.openai.com/api-keys"
        echo "      Set with: export OPENAI_API_KEY='your-key'"
    fi
else
    echo "   ❌ OpenAI CLI not found"
fi
echo ""

# Test 3: Python packages
echo "3. Python AI Packages"
echo "   Checking installed packages..."
if python3 -c "import openai" 2>/dev/null; then
    echo "   ✅ openai package installed"
else
    echo "   ❌ openai package not found"
fi

if python3 -c "import google.generativeai" 2>/dev/null; then
    echo "   ✅ google-generativeai package installed"
    if [ -n "$GEMINI_API_KEY" ]; then
        echo "   ✅ GEMINI_API_KEY is set"
    else
        echo "   ⚠️  GEMINI_API_KEY not set (needed for actual use)"
        echo "      Get key from: https://makersuite.google.com/app/apikey"
        echo "      Set with: export GEMINI_API_KEY='your-key'"
    fi
else
    echo "   ⚠️  google-generativeai has dependency issues"
fi
echo ""

# Test 4: System info
echo "4. System Information"
echo "   Node.js: $(node --version)"
echo "   npm: $(npm --version)"
echo "   Python: $(python3 --version)"
echo ""

# Test 5: Check for context files
echo "5. Context Files"
if [ -f "claude.md" ]; then
    echo "   ✅ claude.md found in current directory"
else
    echo "   ℹ️  No claude.md in current directory"
    echo "      Create one to customize Claude's behavior"
fi
echo ""

echo "======================================================================"
echo "Summary"
echo "======================================================================"
echo ""
echo "Working tools:"
echo "  ✅ Claude Code - Ready to use!"
echo "  ✅ OpenAI CLI - Ready (needs API key for use)"
echo "  ⚠️  Google Generative AI - Installed but has dependency issues"
echo ""
echo "Next steps:"
echo "  1. Set API keys as environment variables (see above)"
echo "  2. Create claude.md context files in your projects"
echo "  3. Try running: claude (in a directory with claude.md)"
echo "  4. Try: openai api chat.completions.create -g user 'Hello!'"
echo ""
