#/bin/bash

sed -n '111,114p' ACF.dat | awk '{print $5}'| paste -sd+ | bc
