# 260910_codex-workflow-skills

## Objective
Recreate the Claude workflow skills for Codex.

## Outcome
- User approved applying and pushing the prepared changes.
- All three skills passed the skill-creator validator.
- Installer syntax, fresh/repeated installs, existing-file preservation, older-install upgrades, and paths with spaces passed validation in an isolated clone.
- Patch applicability and whitespace checks passed.

## Files Modified
- `.agents/skills/document/SKILL.md`, `.agents/skills/init-project/SKILL.md`, `.agents/skills/lesson/SKILL.md`: Codex equivalents of the existing Claude skills.
- `install.sh`: install both skill sets and add missing ignore entries on upgrades.
- `README.md`: Codex installation and invocation instructions.

## Patterns Applied
Reuse the existing `.claude/skills/` instructions and installer copy behavior. `memory-bank/systemPatterns.md#Established patterns` remains an uninitialized template.

## Integration Points
- `install.sh:53`: distribute both `.claude/skills/` and `.agents/skills/`.
- `.agents/skills/init-project/SKILL.md:28`: use available Codex question tools.

## Architectural Decisions
Repository-scoped skills live in `.agents/skills/`; Claude skills remain available for Claude Code.

## Artifacts
Changes committed and pushed as requested; see Git history for the commit.
