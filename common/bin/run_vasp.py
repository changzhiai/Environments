#!/usr/bin/env python3
# ASE VASP_SCRIPT: runs $VASP_EXE (default vasp_std; set per site)
import os
import sys

exitcode = os.system(os.environ.get('VASP_EXE', 'vasp_std'))
sys.exit(exitcode >> 8)
