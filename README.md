# Handoff Plugin for Claude Code

Preserve your session context and seamlessly continue work in a fresh context window.

## What it does

When your context window gets large, run `/handoff` to generate a concise summary of your current work (task, status, key files, decisions, next steps). Then run `/clear` — the summary is automatically injected into the fresh context so you can pick up right where you left off.

## Install

```
/plugin install handoff@stefanoshea/claude-handoff-plugin
```

## Usage

1. **When context gets large:** Type `/handoff`
2. **Claude generates a summary** and saves it to `~/.claude/handoff-context.md`
3. **Run `/clear`** to start a fresh context
4. **The summary auto-injects** into the new session and the file is cleaned up

## How it works

- **Skill** (`skills/handoff/SKILL.md`) — Tells Claude how to analyze the conversation and generate a structured handoff summary
- **Hook** (`scripts/handoff-inject.sh`) — A `SessionStart` hook that detects the handoff file after `/clear`, outputs structured JSON with `systemMessage` (shown in UI immediately) and `additionalContext` (injected into Claude's context), then deletes the file
