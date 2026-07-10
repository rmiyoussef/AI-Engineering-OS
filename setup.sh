#!/usr/bin/env bash
#
# AI Engineering OS — Setup Script
# Installs the AI Brain into your project's .ai/ directory
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/YOUR_ORG/AI-Engineering-OS/main/setup.sh | bash
#   cd your-project && bash /path/to/setup.sh
#
# Or manually:
#   cp -r .ai-template .ai && cp CLAUDE.md .

set -euo pipefail

AI_DIR=".ai"
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${CYAN}  AI Engineering OS — Brain Installer${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Find the script's own directory (supports symlinks)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Check if we're in the project root
if [ ! -f "./composer.json" ] && [ ! -f "./package.json" ] && [ ! -f "./artisan" ]; then
    echo -e "${RED}⚠  Not a project root (no composer.json, package.json, or artisan found)${NC}"
    echo "   Run this from your project's root directory."
    echo ""
    echo "   Example:"
    echo "   cd /path/to/your-project"
    echo "   bash setup.sh"
    echo ""
    exit 1
fi

# Check if already installed
if [ -f "$AI_DIR/CLAUDE.md" ]; then
    echo -e "${RED}⚠  AI Engineering OS is already installed in .ai/${NC}"
    echo "   Remove .ai/ first to reinstall: rm -rf .ai/"
    echo ""
    exit 1
fi

echo -e "📦 Installing AI Brain into ${CYAN}$AI_DIR/${NC}..."
echo ""

# Create .ai directory structure
mkdir -p "$AI_DIR"/{brain,agents,skills,rules,templates,workflows}
mkdir -p "memory"/{decisions,architecture,lessons,sessions,business}

# Copy all OS files into .ai/
echo "   ├── Copying brain files..."
cp "$SCRIPT_DIR"/brain/*.md "$AI_DIR/brain/"

echo "   ├── Copying agents..."
cp "$SCRIPT_DIR"/agents/*.md "$AI_DIR/agents/"

echo "   ├── Copying skills..."
cp "$SCRIPT_DIR"/skills/*.md "$AI_DIR/skills/"

echo "   ├── Copying rules..."
cp "$SCRIPT_DIR"/rules/*.md "$AI_DIR/rules/"

echo "   ├── Copying templates..."
cp "$SCRIPT_DIR"/templates/*.md "$AI_DIR/templates/"

echo "   ├── Copying workflows..."
cp "$SCRIPT_DIR"/workflows/*.md "$AI_DIR/workflows/"

echo "   └── Copying CLAUDE.md (installed mode)..."
cp "$SCRIPT_DIR"/CLAUDE.install.md "$AI_DIR/CLAUDE.md"

echo "   └── Creating project memory directory..."
echo ""

# Create symlink for CLAUDE.md in project root
ln -sf "$AI_DIR/CLAUDE.md" "./CLAUDE.md"

echo -e "${GREEN}✅  AI Engineering OS installed successfully!${NC}"
echo ""
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo "  Project structure:"
echo ""
echo "  $(pwd)/"
echo "  ├── CLAUDE.md → .ai/CLAUDE.md        ← The Brain"
echo "  ├── .ai/"
echo "  │   ├── brain/                       ← System definitions"
echo "  │   ├── agents/                      ← Agent roles"
echo "  │   ├── skills/                      ← Domain knowledge"
echo "  │   ├── rules/                       ← Engineering rules"
echo "  │   ├── templates/                   ← Memory templates"
echo "  │   └── workflows/                   ← Workflow references"
echo "  └── memory/                          ← YOUR project memory"
echo "      ├── decisions/"
echo "      ├── architecture/"
echo "      ├── lessons/"
echo "      ├── sessions/"
echo "      └── business/"
echo ""
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo "  Next steps:"
echo ""
echo "  1. Open this project in VS Code"
echo "  2. Run: claude"
echo "  3. Try: 'Show me the structure of this project'"
echo "  4. Or:  'Add validation to the UserController'"
echo ""
echo -e "${GREEN}  The Brain is ready. Agents are waiting.${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
