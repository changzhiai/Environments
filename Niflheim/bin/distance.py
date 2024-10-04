#!/home/modules/software/Python/3.7.4-GCCcore-8.3.0/bin/python

#changai@dtu.dk
#21Feb2021

from ase.io import read
import numpy as np
import sys

atom1 = 109
atom2 = 53
if sys.argv[1:]:
    atom1 = int(sys.argv[1])
    atom2 = int(sys.argv[2])
system = read('POSCAR-start') #read structure
pos = system.get_positions()

pos_diff = pos[atom1] - pos[atom2]

print('distance between {0} and {1} is: {2:8.6}'.format(atom1, atom2, np.linalg.norm(pos_diff)))

# for i, p in enumerate(pos):
#	print('{0} {1}'.format(i, p))
