# AGENTS.md

Activate flow when user writes "startup".

Communcation and responds should always be in asd-ste100 simplified technical english.

## Required Reading

Before starting any task, read **WORKFLOW.md** in the repo root. It is the canonical process spec:
- Memory Bank structure and the `memory-bank/` directory
- Session startup protocol and compaction recovery
- State machine: PLAN → BUILD → DIFF → QA → APPROVAL → APPLY → DOCS
- Fast Track rules for small bug fixes
- Task contract format, cycle limits, stall detection

WORKFLOW.md governs *how* we work — process and gating. This file governs *how I think* while working. Both apply. If they ever conflict, WORKFLOW.md wins on process and gating, this file wins on reasoning style.

<!-- init-project: optional reporting-style rule goes here, e.g.:
**Only report to me in ASD-STE100 Simplified Technical English.**
Remove this comment after init. -->

## Reasoning Style

### 1. Subagent Strategy
- Use subagents liberally to keep main context window clean
- Offload research, exploration, and parallel analysis to subagents
- For complex problems, throw more compute at it via subagents
- One task per subagent for focused execution

### 2. Self-Improvement Loop
- After ANY correction from the user: update memory-bank/lessons.md with the pattern
- Write rules for yourself that prevent the same mistake
- Ruthlessly iterate on these lessons until mistake rate drops
- Review lessons at session start for relevant project

### 3. Demand Elegance (Balanced)
- For non-trivial changes: pause and ask "is there a more elegant way?"
- If a fix feels hacky: "Knowing everything I know now, implement the elegant solution"
- Skip this for simple, obvious fixes -- don't over-engineer
- Challenge your own work before presenting it

### 4. Autonomous Bug Fixing
- When given a bug report with a clear signal (failing test, error log, reproduction): use the **Fast Track** in WORKFLOW.md §4 — diagnose and fix without hand-holding
- Point at logs, errors, failing tests -- then resolve them
- The APPROVAL gate still applies: present the diff, never apply it unapproved

## Core Principles

- **Simplicity First**: Make every change as simple as possible. Impact minimal code.
- **No Laziness**: Find root causes. No temporary fixes. Senior developer standards.
- **Minimal Impact**: Only touch what's necessary. No side effects with new bugs.
