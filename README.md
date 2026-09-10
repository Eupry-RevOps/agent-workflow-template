# Agent workflow scaffold

The project setup I use for AI-assisted development, packaged so you can drop it into any repo. It gives Claude (or Codex, Cursor, Cline, Aider — anything AGENTS.md-compatible) persistent memory across sessions and a gated process for making changes.

Three parts:

- **WORKFLOW.md** — the process spec. Session startup, the PLAN → BUILD → DIFF → QA → APPROVAL → APPLY → DOCS state machine, a fast track for small bug fixes, approval gates, stall detection, compaction recovery.
- **CLAUDE.md + AGENTS.md** — the tool entry files: reasoning style plus a pointer to WORKFLOW.md. Subagents for research, elegance checks, lessons after corrections. Claude Code reads CLAUDE.md; Codex, Cursor, Cline, and Aider read AGENTS.md, which is an identical copy. Edit one, mirror the other.
- **memory-bank/** — the agent's only persistent memory. Project brief, architecture patterns, tech context, active work, decisions, plus a monthly task log. Sessions start by reading it and end by updating it.

Skills in `.claude/skills/` (Claude Code) and `.agents/skills/` (Codex) come along with the scaffold, so every project set up this way has the same commands. In the new-project route they're committed and travel with the repo; in the existing-project route the installer gitignores them, so each teammate installs their own copy.

## Setup

### New project

```bash
git clone https://github.com/FrederikEupry/agent-workflow-template.git my-project
cd my-project
rm -rf .git && git init
```

Open it in Codex and run `$init-project`, or in Claude Code and run `/init-project`. The folder is empty, so it interviews you (name, goals, users, stack, constraints) and fills the memory bank from your answers.

### Existing project

```bash
git clone https://github.com/FrederikEupry/agent-workflow-template.git
./agent-workflow-template/install.sh /path/to/your/project
```

The installer copies the workflow files and skips anything that already exists, so your current CLAUDE.md or docs are safe. It also appends the installed paths to the project's `.gitignore` (in a clearly marked block), so the workflow stays local to your machine and out of the team's repo — teammates who want it run `install.sh` themselves. Rerunning the installer adds missing skill files and ignore entries, including Codex skills in projects installed with an older version. If you'd rather commit the workflow for the whole team, remove the scaffold entries from `.gitignore`. Then open the project in Codex and run `$init-project`, or in Claude Code and run `/init-project`. With code present, it analyzes the repo instead of interviewing you: it sweeps the codebase with subagents, fills the memory bank with cited facts, and only asks you what the code can't answer (vision, users, non-goals).

## Daily use

| Codex | Claude Code | What happens |
|---|---|---|
| `startup` | `startup` | Activates the flow: startup confirmation, memory bank loaded, lessons reviewed |
| `$init-project` | `/init-project` | Bootstraps the structure (once per project) |
| `$document` | `/document` | Runs the DOCS state: task doc, monthly README, memory-bank updates |
| `$lesson` | `/lesson` | Captures a correction into `memory-bank/lessons.md` so it doesn't happen twice |

The state machine does the rest. The agent plans, you approve, it builds and tests, you approve again, then it applies and documents. Nothing is applied and nothing is documented without your explicit go-ahead.

## What's in the memory bank

See `memory-bank/toc.md` for the full table. The short version: `projectbrief.md` holds vision and goals, `systemPatterns.md` holds architecture and the trap encyclopedia, `activeContext.md` holds what's in flight right now, and `memory-bank/tasks/YYYY-MM/` holds a dated doc per completed task. Template files carry `<!-- init-project: ... -->` comments telling the init skill what belongs where; they're removed on init.

## Honest caveat

The memory bank is only as good as its upkeep. If you skip `$document` (Codex) or `/document` (Claude Code) after tasks, `activeContext.md` drifts from reality and the next session starts on stale ground. The workflow front-loads that discipline; it doesn't remove the need for it.

## Reference

Structure taken from a live project (an MCP server for our data warehouse) where it has run since 2026-08. WORKFLOW.md is v3.0 and self-contained; everything the agent needs to follow the process is in that one file. (v3.0 renamed AGENTS.md to WORKFLOW.md, cut the ceremony — session logs, token budgets, the worked example — and added the fast track for small fixes.)
