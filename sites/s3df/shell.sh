# SLAC S3DF (Slurm)

# Source all files under ~/.profile.d (S3DF convention)
if [[ -d ~/.profile.d && -n "$(ls -A ~/.profile.d/)" ]]; then
    source <(cat $(find -L ~/.profile.d -name '*.conf' | sort))
fi

alias python='python3.8'
alias pip='pip-3.8'
[ -x "$HOME/softwares/anoconda3/bin/conda" ] && alias conda="$HOME/softwares/anoconda3/bin/conda"

export EASYBUILD_MODULES_TOOL=Lmod
export EASYBUILD_PREFIX=$SCRATCH/softwares/easybuild
if command -v module >/dev/null 2>&1 && [ -d "$EASYBUILD_PREFIX/modules/all" ]; then
    module use "$HOME/softwares/modules"
    module use "$EASYBUILD_PREFIX/modules/all"
    module load EasyBuild
fi

_mq_complete="$HOME/.local/lib/python3.8/site-packages/myqueue/complete.py"
[ -f "$_mq_complete" ] && complete -o default -C "/usr/bin/python3.8 $_mq_complete" mq
unset _mq_complete

_libxc="$HOME/softwares/libxc/install"
export C_INCLUDE_PATH=$_libxc/include:$C_INCLUDE_PATH
export LIBRARY_PATH=$_libxc/lib:$LIBRARY_PATH
export LD_LIBRARY_PATH=$_libxc/lib:$LD_LIBRARY_PATH
unset _libxc
