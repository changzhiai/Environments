# Environments shell init: sourced from ~/.bashrc (and ~/.zshrc on macOS).
# Expects ENV_ROOT, ENV_OS, ENV_SITE, ENV_SCHED (written by install.sh).

[ -n "${ENV_ROOT:-}" ] || return 0

env_path_prepend() {
    [ -d "$1" ] || return 0
    case ":$PATH:" in
        *":$1:"*) ;;
        *) PATH="$1:$PATH" ;;
    esac
}

# Lowest priority first: common < scheduler < site < local
env_path_prepend "$ENV_ROOT/common/bin"
env_path_prepend "$ENV_ROOT/scheduler/$ENV_SCHED/bin"
env_path_prepend "$ENV_ROOT/sites/$ENV_SITE/bin"
env_path_prepend "$ENV_ROOT/local/bin"
export PATH

for _env_f in \
    "$ENV_ROOT/common/shell.sh" \
    "$ENV_ROOT/scheduler/$ENV_SCHED/shell.sh" \
    "$ENV_ROOT/sites/$ENV_SITE/shell.sh" \
    "$ENV_ROOT/local/shell.sh"; do
    [ -f "$_env_f" ] && . "$_env_f"
done
unset _env_f
