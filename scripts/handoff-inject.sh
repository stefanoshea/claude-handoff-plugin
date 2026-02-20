#!/bin/bash
# Injects handoff context after /clear and removes the file
# This hook is triggered by SessionStart with matcher "clear"

HANDOFF_FILE="$HOME/.claude/handoff-context.md"

if [ -f "$HANDOFF_FILE" ]; then
    cat "$HANDOFF_FILE"
    rm "$HANDOFF_FILE"
    exit 0
else
    exit 0
fi
