#!/bin/sh
FILE=$1

sed -n '1,/^[dD]/p' $FILE > tmp1
num=`sed -n '7p' tmp1 | awk 'BEGIN{sum=0}{for(i=1;i<=NF;i++)sum+=$i; print sum}'`
sed -n '/^[dD]/,+'$num'p' $FILE > tmp2
sed -i '1d' tmp2
sed -i '/^[dD]/c\\Cartisian' tmp1

a1=`sed -n '3p' tmp1 | awk '{print $1}'`; a2=`sed -n '4p' tmp1 | awk '{print $1}'`; a3=`sed -n '5p' tmp1 | awk '{print $1}'`
b1=`sed -n '3p' tmp1 | awk '{print $2}'`; b2=`sed -n '4p' tmp1 | awk '{print $2}'`; b3=`sed -n '5p' tmp1 | awk '{print $2}'`
c1=`sed -n '3p' tmp1 | awk '{print $3}'`; c2=`sed -n '4p' tmp1 | awk '{print $3}'`; c3=`sed -n '5p' tmp1 | awk '{print $3}'`

sed -n '8p' $FILE | grep "^[Ss]" > /dev/null
if [ $? -ne 0 ]
then
awk '{printf"     %13.9f    %13.9f    %13.9f\n", $1*'$a1'+$2*'$a2'+$3*'$a3', $1*'$b1'+$2*'$b2'+$3*'$b3', $1*'$c1'+$2*'$c2'+$3*'$c3'}' tmp2 > tmp3
else
awk '{printf"     %13.9f    %13.9f    %13.9f   %s   %s   %s\n", $1*'$a1'+$2*'$a2'+$3*'$a3', $1*'$b1'+$2*'$b2'+$3*'$b3', $1*'$c1'+$2*'$c2'+$3*'$c3', $4, $5, $6}' tmp2 > tmp3
fi

cat tmp1 > $1-cart
cat tmp3 >> $1-cart

rm tmp1 tmp2 tmp3
