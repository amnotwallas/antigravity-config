#!/bin/bash

# ---------- Colors ----------

RESET="\033[0m"

GREEN="\033[32m"
YELLOW="\033[33m"
RED="\033[31m"
CYAN="\033[36m"
MAGENTA="\033[35m"

# ---------- Read payload ----------

JSON=$(cat)

# ---------- Git ----------

BRANCH=$(git branch --show-current 2>/dev/null)

if [ -z "$BRANCH" ]; then
    BRANCH="-"
fi

if git diff --quiet 2>/dev/null; then
    DIRTY=false
else
    DIRTY=true
fi

if [ "$DIRTY" = true ]; then
    GIT="${RED}⎇  ${BRANCH}*${RESET}"
else
    GIT="${GREEN}⎇  ${BRANCH}${RESET}"
fi

# ---------- Context ----------

CTX=$(echo "$JSON" | jq -r '.context_window.used_percentage // 0')
CTX=$(printf "%.0f" "$CTX")

if [ "$CTX" -ge 80 ]; then
    CTX_COLOR="$RED"
elif [ "$CTX" -ge 50 ]; then
    CTX_COLOR="$YELLOW"
else
    CTX_COLOR="$GREEN"
fi

CTX_DISPLAY="${CTX_COLOR}ctx ${CTX}%${RESET}"

# ---------- AI Quota ----------

AI=$(echo "$JSON" | jq -r '.quota["gemini-5h"].remaining_fraction // 1')

AI=$(awk "BEGIN { printf \"%.0f\", $AI * 100 }")

if [ "$AI" -le 20 ]; then
    AI_COLOR="$RED"
elif [ "$AI" -le 50 ]; then
    AI_COLOR="$YELLOW"
else
    AI_COLOR="$GREEN"
fi

AI_DISPLAY="${AI_COLOR}AI ${AI}%${RESET}"

# ---------- Reset ----------

RESET_SEC=$(echo "$JSON" | jq -r '.quota["gemini-5h"].reset_in_seconds // 0')

HOURS=$((RESET_SEC / 3600))
MINUTES=$(((RESET_SEC % 3600) / 60))

if [ "$HOURS" -gt 0 ]; then
    RESET_TEXT="${HOURS}h${MINUTES}m"
else
    RESET_TEXT="${MINUTES}m"
fi

RESET_DISPLAY="${CYAN}↺ ${RESET_TEXT}${RESET}"

# ---------- Agent State ----------

STATE=$(echo "$JSON" | jq -r '.agent_state // "idle"')

case "$STATE" in
    idle)
        STATE_DISPLAY="${GREEN}${STATE}${RESET}"
        ;;
    thinking)
        STATE_DISPLAY="${YELLOW}${STATE}${RESET}"
        ;;
    working)
        STATE_DISPLAY="${CYAN}${STATE}${RESET}"
        ;;
    tool_use)
        STATE_DISPLAY="${MAGENTA}${STATE}${RESET}"
        ;;
    initializing)
        STATE_DISPLAY="${YELLOW}${STATE}${RESET}"
        ;;
    *)
        STATE_DISPLAY="$STATE"
        ;;
esac

# ---------- Output ----------

echo -e "${GIT} / ${CTX_DISPLAY} / ${AI_DISPLAY} / ${RESET_DISPLAY} / ${STATE_DISPLAY}"
