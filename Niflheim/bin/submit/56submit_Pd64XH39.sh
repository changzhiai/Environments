#!/bin/bash
#SBATCH --mail-user=changai@dtu.dk
#SBATCH --mail-type=ALL
#SBATCH -N 1
#SBATCH -n 56
#SBATCH --time=50:00:00
###SBATCH --mem=4G  #4 GB RAM per node
#SBATCH --output=mpi_job_slurm.log
#SBATCH --job-name=re_HOCO
#SBATCH --partition=xeon56
export CPU_ARCH=icelake
#module purge
module use /home/energy/modules/modules/all # added into env variable
#module load VASP/5.4.4-intel-2019b
module load VASP
module load ASE
#module load ASE/3.20.1-intel-2019b-Python-3.7.4
export ASE_VASP_VDW=/home/energy/modules/software/VASP/vasp-potpaw-5.4
export VASP_PP_PATH=/home/energy/modules/software/VASP/vasp-potpaw-5.4/
export ASE_VASP_COMMAND="mpiexec -n 56 vasp_std"  #for Vasp
python ./adsorption_energy.py 36 Pd64XH39 top1 HOCO > results
