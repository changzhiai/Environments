from ase.io import read,write
from ase.constraints import FixAtoms, FixedLine

atoms = read('POSCAR')
mask = [atom.z < 25.0 for atom in atoms]
atoms.set_constraint(FixAtoms(mask=mask))
# atoms.set_constraint(FixedLine(indices=63, direction=[0, 0, 1]))
write('POSCAR', atoms)
