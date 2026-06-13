#!/bin/bash
set -euo pipefail

DATA=$(cat)

STATE=$(echo "$DATA" | jq -r '.agent_state // "idle"')
CWD=$(echo "$DATA" | jq -r '.workspace.current_dir // ""')

PROJECT=$(basename "$CWD")

BRANCH=$(git branch --show-current 2>/dev/null || echo "-")

echo "$PROJECT | ⎇ $BRANCH | $STATE"
