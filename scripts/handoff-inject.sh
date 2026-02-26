#!/bin/bash
# SessionStart hook (matcher: "clear") — loads handoff context after /clear
# systemMessage: full summary shown to the user immediately in the UI
# additionalContext: injected into Claude's context for first response

HANDOFF_FILE="$HOME/.claude/handoff-context.md"

if [ -f "$HANDOFF_FILE" ]; then
  CONTENT=$(cat "$HANDOFF_FILE")
  rm "$HANDOFF_FILE"

  jq -n \
    --arg msg "📋 Resuming from handoff:

$CONTENT" \
    --arg ctx "HANDOFF CONTEXT LOADED. The user has been shown the summary via systemMessage. You have full context of the previous session. When the user sends their first message, address it directly — no need to re-display the summary unless asked.

$CONTENT" \
    '{
      systemMessage: $msg,
      hookSpecificOutput: {
        hookEventName: "SessionStart",
        additionalContext: $ctx
      }
    }'
else
  exit 0
fi
