#!/bin/sh
# Install claude-switch into ~/.local/bin (override with PREFIX=/some/dir)
set -e
DEST="${PREFIX:-$HOME/.local/bin}"
REPO="neonxsl/claude-switch"
command -v python3 >/dev/null || { echo "claude-switch needs python3" >&2; exit 1; }
# Pin to the latest commit so raw.githubusercontent.com's cache can't serve a stale copy.
SHA=$(curl -fsSL "https://api.github.com/repos/$REPO/commits/main" | sed -n 's/^  "sha": "\([0-9a-f]*\)".*/\1/p' | head -1)
REF="${SHA:-main}"
mkdir -p "$DEST"
curl -fsSL "https://raw.githubusercontent.com/$REPO/$REF/claude-switch" -o "$DEST/claude-switch"
chmod +x "$DEST/claude-switch"
"$DEST/claude-switch" --version
echo "installed $DEST/claude-switch"
case ":$PATH:" in *":$DEST:"*) ;; *) echo "note: add $DEST to your PATH" ;; esac
FIRST=$(command -v claude-switch 2>/dev/null || true)
[ -n "$FIRST" ] && [ "$FIRST" != "$DEST/claude-switch" ] && echo "warning: '$FIRST' comes first on PATH and will shadow this install" >&2
exit 0
