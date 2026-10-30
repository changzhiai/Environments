# macOS laptop

# Homebrew
for _brew in /opt/homebrew/bin/brew /usr/local/bin/brew; do
    if [ -x "$_brew" ]; then
        eval "$("$_brew" shellenv)"
        break
    fi
done
unset _brew

# Prefer GNU tools (brew install coreutils gnu-sed grep) so the scripts behave as on Linux
if [ -n "${HOMEBREW_PREFIX:-}" ]; then
    for _g in coreutils gnu-sed grep findutils; do
        [ -d "$HOMEBREW_PREFIX/opt/$_g/libexec/gnubin" ] && PATH="$HOMEBREW_PREFIX/opt/$_g/libexec/gnubin:$PATH"
    done
    unset _g
fi

export CLICOLOR=1
