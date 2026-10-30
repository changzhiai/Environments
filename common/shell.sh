# Shared aliases and environment for every machine.

alias ll='ls -l'
alias la='ls -la'

export EDITOR="${EDITOR:-vim}"

# VASP helpers
export VASP_EXE="${VASP_EXE:-vasp_std}"
export ENV_DATA="$ENV_ROOT/common/data"

# Concatenate POTCARs: cpot Pd H O  (needs VASP_PP_PATH set by the site)
cpot() {
    local pp="${VASP_PP_PATH:?VASP_PP_PATH is not set}/potpaw_PBE"
    local i
    for i in "$@"; do
        cat "$pp/$i/POTCAR" >> POTCAR
    done
}
