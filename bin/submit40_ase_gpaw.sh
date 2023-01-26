#!/bin/bash
#SBATCH --mail-user=changai@dtu.dk
#SBATCH --mail-type=ALL
#SBATCH -N 1
#SBATCH -n 40
#SBATCH --time=50:00:00
###SBATCH --mem=4G     # 4 GB RAM per node
#SBATCH --output=mpi_job_slurm.log
#SBATCH --job-name=test40
#SBATCH --partition=xeon40

ulimit -s unlimited

export CPU_ARCH=skylake
module purge
module load ASE/3.20.1-intel-2019b-Python-3.7.4
module load GPAW/20.10.0-intel-2019b-ASE-3.20.1-Python-3.7.4


echo -n "start time  " > time
date >> time

##### run vasp ######
#mpirun $VASP > results
#python relax.py > ase.out
mpiexec gpaw python finalProject4.py
echo -n "end   time  " >> time ; date >> time
