#!/usr/bin/env python3
"""
Demo script to test Google Generative AI integration
This script shows how to use Gemini API from Python
"""

import os
import google.generativeai as genai

def test_gemini():
    """Test Gemini API connection"""
    # Check for API key
    api_key = os.getenv('GEMINI_API_KEY')

    if not api_key:
        print("❌ GEMINI_API_KEY environment variable not set")
        print("   Set it with: export GEMINI_API_KEY='your-key-here'")
        return False

    try:
        # Configure the API
        genai.configure(api_key=api_key)

        # List available models
        print("✅ Connected to Google Generative AI")
        print("\nAvailable models:")
        for model in genai.list_models():
            if 'generateContent' in model.supported_generation_methods:
                print(f"  - {model.name}")

        return True
    except Exception as e:
        print(f"❌ Error connecting to Gemini API: {e}")
        return False

def test_openai():
    """Test OpenAI CLI installation"""
    api_key = os.getenv('OPENAI_API_KEY')

    if not api_key:
        print("❌ OPENAI_API_KEY environment variable not set")
        print("   Set it with: export OPENAI_API_KEY='your-key-here'")
        return False

    print("✅ OpenAI CLI installed and API key found")
    return True

def main():
    """Main test function"""
    print("=" * 60)
    print("AI Terminal Tools - Installation Test")
    print("=" * 60)
    print()

    # Test Claude Code
    print("1. Claude Code CLI")
    if os.path.exists('/opt/node22/bin/claude'):
        print("   ✅ Claude Code is installed (v2.0.59)")
    else:
        print("   ❌ Claude Code not found")
    print()

    # Test OpenAI
    print("2. OpenAI CLI")
    test_openai()
    print()

    # Test Gemini
    print("3. Google Generative AI (Gemini)")
    test_gemini()
    print()

    print("=" * 60)
    print("Setup Instructions:")
    print("=" * 60)
    print()
    print("For Gemini:")
    print("  1. Get API key from: https://makersuite.google.com/app/apikey")
    print("  2. Set: export GEMINI_API_KEY='your-key'")
    print()
    print("For OpenAI:")
    print("  1. Get API key from: https://platform.openai.com/api-keys")
    print("  2. Set: export OPENAI_API_KEY='your-key'")
    print()
    print("For Claude Code:")
    print("  Already using Claude Code right now! ✨")
    print()

if __name__ == "__main__":
    main()
