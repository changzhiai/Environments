#!/usr/bin/env bash
# Undo install.sh: remove the rc-file block and our symlinks, restore the newest backups.
set -euo pipefail

ENV_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MARK_BEGIN='# >>> Environments >>>'
MARK_END='# <<< Environments <<<'

for rc in "$HOME/.bashrc" "$HOME/.zshrc"; do
    if grep -qsF "$MARK_BEGIN" "$rc"; then
        tmp="$(mktemp)"
        awk -v b="$MARK_BEGIN" -v e="$MARK_END" '$0 == b {skip=1} !skip {print} $0 == e {skip=0}' "$rc" |
            awk 'NF {for (; n > 0; n--) print ""; print; next} {n++}' > "$tmp"
        cat "$tmp" > "$rc"
        rm -f "$tmp"
        echo "removed block from $rc"
    fi
done

for dst in "$HOME/.vimrc" "$HOME/.config/flake8" "$HOME/.config/.flake8"; do
    if [ -L "$dst" ] && [[ "$(readlink "$dst")" == "$ENV_ROOT"/* ]]; then
        rm "$dst"
        echo "removed $dst"
        bak="$(ls -1d "$dst".bak.* 2>/dev/null | sort | tail -1 || true)"
        if [ -n "$bak" ]; then
            mv "$bak" "$dst"
            echo "restored $dst from $bak"
        fi
    fi
done

echo "Done. vim plugins in ~/.vim were left in place."
