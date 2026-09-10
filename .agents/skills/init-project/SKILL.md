---
name: init-project
description: Initialize the workflow scaffold (AGENTS.md, CLAUDE.md, WORKFLOW.md, memory bank) in this folder. Use when the user asks to init, set up, or bootstrap the project workflow — in an empty folder (interview mode) or an existing codebase (analysis mode).
---

# Init project

Set up the memory-bank workflow in the current folder. Two modes, chosen automatically.

## Step 0 — verify the scaffold is present

Check for `WORKFLOW.md`, `CLAUDE.md`, `AGENTS.md`, and `memory-bank/` in the repo root. (`AGENTS.md` is an identical copy of `CLAUDE.md` for Codex/Cursor/Cline/Aider.)

- If missing and this skill arrived via the workflow template repo, copy them from the template (same source this `.agents/skills/` folder came from, or run its `install.sh`).
- If you cannot locate the template, ask the user for its path or URL. Do not improvise a different structure — WORKFLOW.md is the canonical spec.

Read `WORKFLOW.md` §3 (Memory Bank) before writing anything.

## Step 1 — detect mode

Look at the repo root, ignoring the workflow files themselves (`WORKFLOW.md`, `CLAUDE.md`, `AGENTS.md`, `memory-bank/`, `.claude/`, `.agents/`, `README.md`, `.git`, `install.sh`, dotfiles).

- **Nothing else there → Interview mode** (greenfield project).
- **Source code, configs, or docs present → Analysis mode** (existing project).

## Step 2a — interview mode (empty folder)

Ask the user using an available Codex question tool when appropriate, or concise plain-text questions when no suitable tool is available. Respect the active mode and tool restrictions. Keep it to two rounds maximum:

1. Project name and one-sentence vision (what outcome it exists to produce)
2. Goals (2–4, concrete) and explicit non-goals
3. Who uses it / who owns it
4. Intended stack and where it will run (may be "undecided" — record that honestly)
5. Any hard constraints (security, cost, compliance)
6. Optional reporting-style rule for CLAUDE.md (e.g. ASD-STE100 Simplified Technical English). Apply the answer to both CLAUDE.md and AGENTS.md; if declined, delete the placeholder comment from both.

Fill the memory-bank templates from the answers. Leave sections the user could not answer as marked open items in `activeContext.md` — never pad with invented content.

## Step 2b — analysis mode (existing codebase)

Populate the memory bank from evidence in the repo. Rules:

- When Codex subagents are available and permitted, delegate independent parts of the codebase sweep: structure, entry points, stack, build/test/deploy commands, existing docs (README, package.json scripts, CI config). Otherwise perform the sweep directly using file searches and focused reads.
- Every claim written to the memory bank gets a `file:line` or file-level citation, per WORKFLOW.md §1.
- Git history (if present) feeds `progress.md` and `activeContext.md`: recent commits become the "recent history" seed.
- What the code cannot tell you — vision, users, non-goals, the why behind visible decisions — ask the user in ONE consolidated round of questions after the sweep. Do not guess.
- If the project already has a CLAUDE.md or agent instructions, merge: existing project-specific rules survive; the workflow structure from the template wraps around them. Show the user the merged CLAUDE.md before writing it, then mirror the result into AGENTS.md.

Fill, at minimum: `projectbrief.md`, `techContext.md`, `systemPatterns.md`, `quick-start.md`, `build-deployment.md`, `activeContext.md`, `progress.md`, `toc.md`. Create `testing-patterns.md` and `projectRules.md` with real content if the repo has tests/conventions, otherwise leave the templates with an open-item note.

## Step 3 — finish (both modes)

1. Create `memory-bank/tasks/<current YYYY-MM>/README.md` with a first entry: "YYYY-MM-DD: workflow initialized (interview|analysis mode)".
2. Update `memory-bank/toc.md` to match the files that actually exist. Remove init-project comments from all files you filled.
3. Output the one-line startup confirmation from WORKFLOW.md §1.
4. Tell the user: type `startup` at the start of every future session to activate the flow.

## Hard rules

- `CLAUDE.md` and `AGENTS.md` are identical copies (only the title line differs). Any edit to one must be mirrored in the other.
- Never overwrite non-template content without showing a diff and getting approval.
- Never fabricate facts to make a memory-bank file look complete. A short honest file beats a padded one.
- Placeholders (`[PROJECT NAME]`, `<!-- init-project: ... -->`) must all be gone or converted to explicit open items by the time you finish.
