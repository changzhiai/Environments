#!/bin/bash
#SBATCH --mail-user=changai@dtu.dk
#SBATCH --mail-type=ALL
#SBATCH -N 1
#SBATCH -n 56
#SBATCH --time=50:00:00
###SBATCH --mem=4G     # 4 GB RAM per node
#SBATCH --output=mpi_job_slurm.log
#SBATCH --job-name=submit56
#SBATCH --partition=xeon56

ulimit -s unlimited

export CPU_ARCH=icelake
#export VASP_SCRIPT=$HOME/bin/run_vasp.py
module use /home/energy/modules/modules/all # added into env variable
module load VASP/5.4.4-intel-2019b
module load ASE/3.20.1-intel-2019b-Python-3.7.4
export ASE_VASP_VDW=/home/energy/modules/software/VASP/vasp-potpaw-5.4
export VASP_PP_PATH=/home/energy/modules/software/VASP/vasp-potpaw-5.4/
export ASE_VASP_COMMAND="mpiexec -n 56 vasp_std"  #for Vasp


echo -n "start time  " > time
date >> time
#run script
python ./free_energy_surface.py > results

echo -n "end   time  " >> time ; date >> time
