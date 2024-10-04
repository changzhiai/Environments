#!/bin/bash
#SBATCH --mail-user=changai@dtu.dk
#SBATCH --mail-type=ALL
#SBATCH -N 1
#SBATCH -n 1
#SBATCH --time=7-00:00:00
###SBATCH --mem=4G     # 4 GB RAM per node
#SBATCH --output=mpi_job_slurm.log
#SBATCH --job-name=4body_100train
#SBATCH --partition=xeon16

if [[ ! -z "$SLURM_JOB_PARTITION" ]]
then
    if [[ "$SLURM_JOB_PARTITION" = "xeon8" ]]
    then
        export CPU_ARCH=nehalem
    elif [[ "$SLURM_JOB_PARTITION" = "xeon16" ]]
    then
        export CPU_ARCH=sandybridge
    elif [[ "$SLURM_JOB_PARTITION" = "xeon24" ]]
    then
        export CPU_ARCH=broadwell
    elif [[ "$SLURM_JOB_PARTITION" = "xeon40" ]]
    then
        export CPU_ARCH=skylake
    fi
fi

ulimit -s unlimited

source ~/.bashrc
conda activate clease_fix_slab_v2

echo -n "start time  " > time
date >> time

python ./4body_ce_multi_alex.py

echo -n "end   time  " >> time ; date >> time
