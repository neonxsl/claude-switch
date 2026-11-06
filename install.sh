#!/bin/sh
# Install claude-switch into ~/.local/bin (override with PREFIX=/some/dir)
set -e
DEST="${PREFIX:-$HOME/.local/bin}"
URL="https://raw.githubusercontent.com/neonxsl/claude-switch/main/claude-switch"
command -v python3 >/dev/null || { echo "claude-switch needs python3" >&2; exit 1; }
mkdir -p "$DEST"
curl -fsSL "$URL" -o "$DEST/claude-switch"
chmod +x "$DEST/claude-switch"
echo "installed $DEST/claude-switch"
case ":$PATH:" in *":$DEST:"*) ;; *) echo "note: add $DEST to your PATH" ;; esac
