# NERSC Perlmutter (Slurm)

export VASP_EXE=vasp
export ENV_SUBMIT_TEMPLATE="$ENV_ROOT/sites/perlmutter/templates/submit.sh"

[ -d "$HOME/softwares/conda/bin" ] && export PATH="$HOME/softwares/conda/bin:$PATH"
