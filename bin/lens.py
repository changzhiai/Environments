#!/usr/bin/env /home/energy/changai/software/miniconda3/bin/python
from ase.io import read
import sys

name = sys.argv[1]

images = read(name, ':')
print(len(images))

