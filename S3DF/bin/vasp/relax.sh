#!/bin/bash

NEWFILE='relax'
mkdir $NEWFILE
cp INCAR KPOINTS POTCAR POSCAR submit.sh ../vdw_kernel.bindat $NEWFILE
sed -i 's/ NSW = 0/ NSW = 200/g' $NEWFILE/INCAR

find=`tail -1 $NEWFILE/POSCAR|grep '   T   T   T'`
#echo $find
if [[ -z $find ]]
then
    echo 'There is no T   T   T in POSCAR. Please check POSCAR'
    echo 'Exiting ...'
    exit 1
fi

sed -i 's/   T   T   T/   F   F   T/g' $NEWFILE/POSCAR

#sbatch $NEWFILE/submit.sh

