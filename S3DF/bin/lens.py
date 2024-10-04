#!/global/homes/c/changzhi/softwares/conda/bin/python3

from ase.io import read
import sys

name = sys.argv[1]

images = read(name, ':')
print(len(images))
