#!/usr/bin/env bash
# Install the workflow scaffold into a target project.
# Usage: ./install.sh /path/to/project
# Copies WORKFLOW.md, CLAUDE.md, AGENTS.md, memory-bank/, and skills from
# .claude/skills/ and .agents/skills/,
# and appends those paths to the target's .gitignore so they stay local.
# Never overwrites: existing files in the target are skipped and reported.

set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="${1:-}"

if [[ -z "$TARGET" ]]; then
  echo "Usage: ./install.sh /path/to/project"
  exit 1
fi

mkdir -p "$TARGET"
TARGET="$(cd "$TARGET" && pwd)"

if [[ "$TARGET" == "$SRC" ]]; then
  echo "Target is the template repo itself; nothing to do."
  exit 1
fi

copied=0
skipped=0

copy_file() {
  local rel="$1"
  local dest="$TARGET/$rel"
  if [[ -e "$dest" ]]; then
    echo "skip (exists): $rel"
    skipped=$((skipped + 1))
  else
    mkdir -p "$(dirname "$dest")"
    cp "$SRC/$rel" "$dest"
    echo "copied:        $rel"
    copied=$((copied + 1))
  fi
}

copy_file "WORKFLOW.md"
copy_file "CLAUDE.md"
copy_file "AGENTS.md"

for f in "$SRC"/memory-bank/*.md; do
  copy_file "memory-bank/$(basename "$f")"
done
mkdir -p "$TARGET/memory-bank/tasks"

skill_roots=(".claude/skills" ".agents/skills")
ignore_entries=("/WORKFLOW.md" "/CLAUDE.md" "/AGENTS.md" "/memory-bank/")
for root in "${skill_roots[@]}"; do
  for skill in "$SRC/$root"/*/; do
    name="$(basename "$skill")"
    copy_file "$root/$name/SKILL.md"
    ignore_entries+=("/$root/$name/")
  done
done

GITIGNORE="$TARGET/.gitignore"
MARKER="# --- claude-workflow scaffold (added by install.sh) ---"
updated=0
if [[ ! -f "$GITIGNORE" ]] || ! grep -qFx -- "$MARKER" "$GITIGNORE"; then
  {
    if [[ -s "$GITIGNORE" ]]; then echo; fi
    echo "$MARKER"
  } >> "$GITIGNORE"
  updated=1
fi
for entry in "${ignore_entries[@]}"; do
  if ! grep -qFx -- "$entry" "$GITIGNORE"; then
    # Separate appended entries even when an existing file lacks a final newline.
    if [[ -s "$GITIGNORE" && -n "$(tail -c 1 "$GITIGNORE")" ]]; then
      echo >> "$GITIGNORE"
    fi
    echo "$entry" >> "$GITIGNORE"
    updated=1
  fi
done
if [[ "$updated" == 1 ]]; then
  echo "updated:       .gitignore (missing scaffold entries appended)"
else
  echo "skip (exists): .gitignore scaffold entries"
fi

echo
echo "Done: $copied copied, $skipped skipped (already existed)."
echo 'Next: open the project in Codex and run $init-project, or Claude Code and run /init-project.'
