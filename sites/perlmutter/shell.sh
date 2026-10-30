# NERSC Perlmutter (Slurm)

export VASP_EXE=vasp
export ENV_SUBMIT_TEMPLATE="$ENV_ROOT/sites/perlmutter/templates/submit.sh"

[ -d "$HOME/softwares/conda/bin" ] && export PATH="$HOME/softwares/conda/bin:$PATH"

export HPC_SUMMARY_PARTITIONS="regular_milan_ss11 shared_milan_ss11 gpu_ss11 shared_gpu_ss11 urgent_milan_ss11 urgent_gpu_ss11 realtime_ss11 shared_realtime_ss11 workflow cron"
