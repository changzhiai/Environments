#!/bin/sh
sed -n '1,$p' $1 | awk 'BEGIN{energy=0; dos=0}{energy+=($6+$7+$8+$9+$10)*$1; dos+=($6+$7+$8+$9+$10)}END{dcenter=energy/dos; print dcenter}'
sed -n '1,$p' $1 | awk '{printf "%12.8f %12.8f \n", $1, $6+$7+$8+$9+$10}' > ados.txt
