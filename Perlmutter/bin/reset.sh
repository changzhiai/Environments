#!/bin/bash

cp ~/bin/submit24_vasp.sh .
cp POSCAR POSCAR.start
cp CONTCAR POSCAR
sbatch submit*.sh
