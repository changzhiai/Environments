#/bin/bash

sed -n '111,112p' ACF.dat | awk '{print $5}'| paste -sd+ | bc
