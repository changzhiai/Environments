# PBS helpers
export ENV_SUBMIT_CMD=qsub

# cd into a job's working directory: sqcd <jobid|jobname>
sqcd() { local d; d=$(sqdir "$1") && cd "$d"; }
ficd() { sqcd "$@"; }
