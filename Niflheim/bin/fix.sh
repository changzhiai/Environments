#!/bin/sh

value=$1
sed -i 's/^M//' POSCAR
head -7 POSCAR > poscar.select
echo "Selective dynamics" >> poscar.select
sed -n '8p' POSCAR >> poscar.select
num=`sed -n '7p' poscar.select | awk 'BEGIN{sum=0}{for(i=1;i<=NF;i++)sum+=$i; print sum}'`

sed -n '9,+'$[num-1]'p' POSCAR | awk '{if($3<'$value'){
printf "     %13.9f    %13.9f    %13.9f   F   F   F\n", $1, $2, $3;}
else{
printf "     %13.9f    %13.9f    %13.9f   T   T   T\n", $1, $2, $3;}
}' >> poscar.select

sed -i '1,$s///g' poscar.select

mv poscar.select POSCAR
