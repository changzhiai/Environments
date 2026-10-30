#!/usr/bin/env bash
# Install Environments on this machine: shell tools, vim config, flake8 config.
#
#   ./install.sh [--site NAME] [--scheduler slurm|pbs|none] [--no-vim] [--dry-run]
#
# Safe to re-run: the rc-file block is replaced, existing files are backed up once.
set -euo pipefail

ENV_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MARK_BEGIN='# >>> Environments >>>'
MARK_END='# <<< Environments <<<'
STAMP="$(date +%Y%m%d%H%M%S)"
DRY=0
VIM=1

usage() { sed -n '2,6p' "$0" | sed 's/^# \{0,1\}//'; exit "${1:-0}"; }

while [ $# -gt 0 ]; do
    case "$1" in
        --site)      ENV_SITE="$2"; shift 2 ;;
        --scheduler) ENV_SCHED="$2"; shift 2 ;;
        --no-vim)    VIM=0; shift ;;
        --dry-run)   DRY=1; shift ;;
        -h|--help)   usage ;;
        *)           echo "Unknown option: $1" >&2; usage 1 ;;
    esac
done

. "$ENV_ROOT/lib/detect.sh"
env_detect

[ -d "$ENV_ROOT/sites/$ENV_SITE" ] || { echo "Unknown site '$ENV_SITE' (see $ENV_ROOT/sites)" >&2; exit 1; }
case "$ENV_SCHED" in slurm|pbs|none) ;; *) echo "Unknown scheduler '$ENV_SCHED'" >&2; exit 1 ;; esac

run() {
    if [ "$DRY" = 1 ]; then echo "  [dry-run] $*"; else "$@"; fi
}

# Link $2 -> $1, backing up a real file that is in the way.
link() {
    local src="$1" dst="$2"
    if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
        echo "  ok      $dst"
        return
    fi
    if [ -e "$dst" ] || [ -L "$dst" ]; then
        echo "  backup  $dst -> $dst.bak.$STAMP"
        run mv "$dst" "$dst.bak.$STAMP"
    fi
    echo "  link    $dst -> $src"
    run mkdir -p "$(dirname "$dst")"
    run ln -s "$src" "$dst"
}

# Write (or replace) the marked block in an rc file.
rc_block() {
    local rc="$1" tmp
    local block
    block="$MARK_BEGIN
export ENV_ROOT=\"$ENV_ROOT\" ENV_OS=$ENV_OS ENV_SITE=$ENV_SITE ENV_SCHED=$ENV_SCHED
[ -f \"\$ENV_ROOT/shell/init.sh\" ] && . \"\$ENV_ROOT/shell/init.sh\"
$MARK_END"
    if [ "$DRY" = 1 ]; then
        echo "  [dry-run] write block to $rc:"
        echo "$block" | sed 's/^/      /'
        return
    fi
    touch "$rc"
    tmp="$(mktemp)"
    # drop the old block and the blank lines it leaves at the end of the file
    awk -v b="$MARK_BEGIN" -v e="$MARK_END" '$0 == b {skip=1} !skip {print} $0 == e {skip=0}' "$rc" |
        awk 'NF {for (; n > 0; n--) print ""; print; next} {n++}' > "$tmp"
    printf '\n%s\n' "$block" >> "$tmp"
    cat "$tmp" > "$rc"
    rm -f "$tmp"
    echo "  updated $rc"
}

echo "Environments: $ENV_ROOT"
echo "Detected: os=$ENV_OS site=$ENV_SITE scheduler=$ENV_SCHED"

echo "Shell:"
rc_block "$HOME/.bashrc"
if [ "$ENV_OS" = macos ]; then
    rc_block "$HOME/.zshrc"
    # macOS login shells read ~/.bash_profile, not ~/.bashrc
    if ! grep -qs 'bashrc' "$HOME/.bash_profile"; then
        run sh -c "echo '[ -f ~/.bashrc ] && . ~/.bashrc' >> '$HOME/.bash_profile'"
    fi
fi

echo "Executables:"
run find "$ENV_ROOT/common/bin" "$ENV_ROOT/scheduler" "$ENV_ROOT/sites" -path '*/bin/*' -type f -exec chmod +x {} +
run mkdir -p "$ENV_ROOT/local/bin"
echo "  bin dirs are executable; put machine-only binaries in $ENV_ROOT/local/bin"

echo "Configs:"
link "$ENV_ROOT/common/config/flake8" "$HOME/.config/flake8"
link "$ENV_ROOT/common/config/flake8" "$HOME/.config/.flake8"

if [ "$VIM" = 1 ]; then
    echo "Vim:"
    link "$ENV_ROOT/common/vim/vimrc" "$HOME/.vimrc"
    plug="$HOME/.vim/autoload/plug.vim"
    if [ ! -f "$plug" ]; then
        if command -v curl >/dev/null 2>&1; then
            echo "  fetch   vim-plug"
            run curl -fsSLo "$plug" --create-dirs \
                https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
                || echo "  WARNING: could not download vim-plug (no internet?); vim will retry on start"
        else
            echo "  WARNING: curl not found; install vim-plug manually"
        fi
    fi
    if [ -f "$plug" ] && command -v vim >/dev/null 2>&1; then
        echo "  install vim plugins"
        run vim -E -s -u "$HOME/.vimrc" +PlugInstall +qall </dev/null || true
    fi
fi

echo
echo "Done. Start a new shell or run:  source ~/.bashrc"
