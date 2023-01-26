#!/bin/bash
hv_sum=$(grep "f  =" OUTCAR | awk '{print $10}' | paste -sd+ | bc)
echo "scale = 5; $hv_sum/2000" | bc
