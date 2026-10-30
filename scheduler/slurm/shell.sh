# Slurm helpers
export ENV_SUBMIT_CMD=sbatch
export SQUEUE_FORMAT="%.18i %.9P %.26j %.8u %.10T %.9Q %.10M %.9l %.6D %.6C %R"

# cd into a job's working directory: sqcd <jobid|jobname>
sqcd() { local d; d=$(sqdir "$1") && cd "$d"; }
ficd() { sqcd "$@"; }
