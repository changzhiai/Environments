#!/bin/bash
#SBATCH --mail-user=changai@dtu.dk
#SBATCH --mail-type=ALL
#SBATCH -N 1
#SBATCH -n 16
#SBATCH --time=50:00:00
###SBATCH --mem=47G
#SBATCH --output=mpi_job_slurm.log
#SBATCH --job-name=test
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

#export VASP_SCRIPT=$HOME/bin/run_vasp.py
module use /home/energy/modules/modules/all # added into env variable
module load VASP/5.4.4-intel-2019b
module load ASE/3.20.1-intel-2019b-Python-3.7.4
export ASE_VASP_VDW=/home/energy/modules/software/VASP/vasp-potpaw-5.4
export VASP_PP_PATH=/home/energy/modules/software/VASP/vasp-potpaw-5.4/
export ASE_VASP_COMMAND="mpirun vasp_std"  #for Vasp


echo -n "start time  " > time
date >> time
#run script
python ./free_energy_surface.py > results

echo -n "end   time  " >> time ; date >> time
