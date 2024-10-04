#!/bin/bash
#SBATCH -N 1
#SBATCH -C cpu
#SBATCH -q regular
#SBATCH -t 02:00:00
#SBATCH -J vasp_job
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err

module load vasp/6.4.2-cpu

# Always provide OpenMP settings when running VASP 6
export OMP_NUM_THREADS=2
export OMP_PLACES=threads
export OMP_PROC_BIND=spread

# Run with (-n) 128 total MPI ranks:
#  64 MPI-ranks-per-node
#   2 OpenMP threads-per-MPI-rank
#  Set -c ("--cpus-per-task") = 2 x (OMP_NUM_THREADS) = 4
#   to space processes two "logical cores" apart
srun -n 128  --cpu-bind=cores vasp_std
