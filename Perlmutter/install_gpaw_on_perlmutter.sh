## Automate installation
path=/global/cfs/cdirs/m2997/changzhi/
mkdir gpaw
cd gpaw
wget https://gitlab.com/libxc/libxc/-/archive/6.2.2/libxc-6.2.2.tar.bz2
tar -xvjf libxc-6.2.2.tar.bz2
cd libxc-6.2.2
autoreconf -i
mkdir install 
CFLAGS="-fPIC" FFLAGS="-fPIC" ./configure --prefix=$PWD/install
make
make check
make install
python setup.py build
python setup.py install

cd ..
module load python cray-fftw
conda create --prefix $PWD/gpaw-venv pip numpy scipy matplotlib
source activate $PWD/gpaw-venv
pip install ase
git clone -b 23.9.1 https://gitlab.com/gpaw/gpaw.git
cd gpaw
wget https://raw.githubusercontent.com/NERSC/community-software/main/gpaw/siteconfig.py -O siteconfig.py
sed -i "s#/your/path/to/libxc/6.2.2#$(pwd)/../libxc-6.2.2/install/#g" siteconfig.py
sed -i "s#->elsize##g" $PWD/c/lfc.c
python setup.py build_ext
python setup.py install

cd ..
mkdir dataset
gpaw install-data $PWD/dataset



# How to use
#!/bin/bash
#SBATCH -N 1
#SBATCH -n 128
#SBATCH -C cpu
#SBATCH -q debug
#SBATCH -t 00:20:00
#SBATCH -J gpaw_test
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err

source activate /global/cfs/cdirs/m2997/changzhi/gpaw/gpaw-venv
export OMP_NUM_THREADS=1
export GPAW_SETUP_PATH=/global/cfs/cdirs/m2997/changzhi/gpaw/gpaw-setups-24.1.0 # when using PAW method
srun -n 128 -c 2 python gpaw-test.py
