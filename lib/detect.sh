#!/usr/bin/env bash
# Detect OS, site and job scheduler.
# Sourced by install.sh; run directly to print the result.
# Respects pre-set ENV_OS / ENV_SITE / ENV_SCHED (used for overrides).

env_detect_os() {
    case "$(uname -s)" in
        Darwin) echo macos ;;
        *)      echo linux ;;
    esac
}

env_detect_site() {
    local host
    host="$(hostname -f 2>/dev/null || hostname)"
    if [ "$(env_detect_os)" = macos ]; then
        echo macos
    elif [ "${NERSC_HOST:-}" = perlmutter ]; then
        echo perlmutter
    elif [[ "$host" == *aurora* ]] || [ -d /lus/flare ]; then
        echo aurora
    elif [ -d /sdf ]; then
        echo s3df
    elif [[ "$host" == *niflheim* ]] || [ -d /home/energy ]; then
        echo niflheim
    else
        echo generic
    fi
}

env_detect_sched() {
    if command -v sbatch >/dev/null 2>&1; then
        echo slurm
    elif command -v qsub >/dev/null 2>&1; then
        echo pbs
    else
        echo none
    fi
}

env_detect() {
    ENV_OS="${ENV_OS:-$(env_detect_os)}"
    ENV_SITE="${ENV_SITE:-$(env_detect_site)}"
    ENV_SCHED="${ENV_SCHED:-$(env_detect_sched)}"
    export ENV_OS ENV_SITE ENV_SCHED
}

if [ "${BASH_SOURCE[0]}" = "$0" ]; then
    env_detect
    echo "os=$ENV_OS site=$ENV_SITE scheduler=$ENV_SCHED"
fi
