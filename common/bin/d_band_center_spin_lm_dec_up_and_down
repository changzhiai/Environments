#!/bin/sh
sed -n '1,$p' $1 | awk 'BEGIN{energy=0; dos=0}{energy+=($10-$11+$12-$13+$14-$15+$16-$17+$18-$19)*$1; dos+=($10-$11+$12-$13+$14-$15+$16-$17+$18-$19)}END{dcenter=energy/dos; print dcenter}'
sed -n '1,$p' $1 | awk '{printf "%12.8f %12.8f \n", $1, $10-$11+$12-$13+$14-$15+$16-$17+$18-$19}' > ados.txt
