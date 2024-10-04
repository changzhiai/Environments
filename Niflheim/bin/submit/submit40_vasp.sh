#!/bin/bash
#SBATCH --mail-user=changai@dtu.dk
#SBATCH --mail-type=ALL
#SBATCH -N 1
#SBATCH -n 40
#SBATCH --time=50:00:00
###SBATCH --mem=4G     # 4 GB RAM per node
#SBATCH --output=mpi_job_slurm.log
#SBATCH --job-name=test
#SBATCH --partition=xeon40

export CPU_ARCH=skylake
module use /home/energy/modules/modules/all # added into env variable
module load VASP/5.4.4-intel-2019b
VASP=/home/energy/modules/software/VASP/skylake/VASP-5.4.4_VTST_BEEF_WANNIER90_SOLVATION_intel2019b/bin/vasp_std

ulimit -s unlimited

echo -n "start time  " > time
date >> time

##### run vasp ######
mpirun $VASP > results

echo -n "end   time  " >> time ; date >> time
