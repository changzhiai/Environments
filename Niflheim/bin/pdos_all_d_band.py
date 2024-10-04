from ase.calculators.vasp import Vasp, VaspDos
from ase.dft.pdos import DOS
import matplotlib.pyplot as plt
import numpy as np

calc = Vasp('scf')   # we already ran this!
ados = VaspDos(efermi=calc.get_fermi_level())
energy = ados.energy
pdos = 0
#get d band of all atoms
for i in range(1, 110):
    for each in ['dxy+', 'dyz+', 'dz2+', 'dxz+', 'dx2+']:
        pdos = pdos + ados.site_dos(i, each)
        #print(pdos, type(pdos), pdos.shape)

#energy, pdos = calc.site_ados(49, 'd')
#energy, pdos = calc.get_orbital_ldos(a=49, angular='d')
center = np.trapz(pdos * energy, energy) / np.trapz(pdos, energy)
width = np.sqrt(np.trapz(pdos * energy**2, energy) / np.trapz(pdos, energy))
plt.plot(energy, pdos)
#plt.plot(dos.get_energies(), dos.get_dos())
plt.xlabel('Energy (eV)')
plt.ylabel('d-projected DOS on all atoms')
plt.title('d-band center = %5.3f eV, d-band width = %5.3f eV' % (center, width))

#dos = DOS(calc, width=0.005)
#plt.plot(dos.get_energies(), dos.get_dos())
#plt.xlabel('Energy')
#plt.ylabel('DOS')

# make sure you save the figure outside the with statement, or provide
# the correct relative or absolute path to where you want it.
plt.savefig('pdos_all_d_band.png')
