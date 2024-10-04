#!/bin/sh
sed -n '1,$p' $1 | awk 'BEGIN{energy=0; dos=0}{energy+=($10+$12+$14+$16+$18)*$1; dos+=($10+$12+$14+$16+$18)}END{dcenter=energy/dos; print dcenter}'
sed -n '1,$p' $1 | awk '{printf "%12.8f %12.8f \n", $1, $10+$12+$14+$16+$18}' > ados.txt
