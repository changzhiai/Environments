# DTU Niflheim (Slurm)

PATH="$HOME/Script:$HOME/bin/vtstscripts-967:$PATH"
export PS1='[\u@\h \w]\$ '
alias emacs="emacs -nw"

export ENV_SUBMIT_TEMPLATE="$ENV_ROOT/sites/niflheim/templates/submit24_vasp.sh"

################# add module ###################
module use "$ENV_ROOT/sites/niflheim/module"
module use /home/energy/changai/software/modules
module use /home/energy/modules/modules/all
module use /home/energy/jchang/modules/modules/all

##################### load #########################
module load lrzsz/lrzsz   #lrzsz
module load vesta/vesta-gtk3  #vesta
module load vaspkit/vaspkit  #vaspkit

################## ase-vasp & ase-gpaw ###############
export ASE_VASP_VDW=/home/energy/modules/software/VASP/vasp-potpaw-5.4
export VASP_PP_PATH=/home/energy/modules/software/VASP/vasp-potpaw-5.4/
export ASE_VASP_COMMAND="mpiexec -n 24 vasp_std"
export VASP_SCRIPT="$ENV_ROOT/common/bin/run_vasp.py"

################### catmap #####################
export PYTHONPATH=/home/energy/changai/software/catmap/catmap:$PYTHONPATH
export PYTHONPATH=$PYTHONPATH:/home/energy/changai/software/asc-scripts/
export PATH=$PATH:/home/energy/changai/software/asc-scripts/bin

##################kitchin###############
export PYTHONPATH=/home/energy/changai/software/vasp-python3:$PYTHONPATH
export PATH=/home/energy/changai/software/vasp-python3/bin:$PATH

export MESA_GL_VERSION_OVERRIDE=3.3 # for mayavi

# >>> conda initialize >>>
__conda_setup="$('/home/energy/changai/software/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
elif [ -f "/home/energy/changai/software/miniconda3/etc/profile.d/conda.sh" ]; then
    . "/home/energy/changai/software/miniconda3/etc/profile.d/conda.sh"
else
    export PATH="/home/energy/changai/software/miniconda3/bin:$PATH"
fi
unset __conda_setup
# <<< conda initialize <<<
conda deactivate 2>/dev/null
alias python3=python3.11
