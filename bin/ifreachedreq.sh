#!/bin/bash

starttime=$1
#i=$(sacct --starttime 2021-04-29| grep 'COMPLETED'| awk '{print $1}'|cut -c -7| uniq| sed -n '3,$p'); for each in $i; do echo $each; ficd $each; grepr; done
i=$(sacct --starttime 2021-$1| grep 'COMPLETED'| awk '{print $1}'|cut -c -7| uniq| sed -n '3,$p')

unconverge=""
for each in $i
do
    echo $each
    ficd $each
    pwd
    grepr
    r=$(grep "reached required" OUTCAR)
    if [ "$r" == "" ];then
    #if [[ -z $r ]];then
	echo $each
        #echo $i >> unconvergedid
	unconverge+="$each "
    fi   
done

echo $unconverge
for id in $unconverge
do
    ficd $id
    pwd

done

echo
echo "================================="
for each in $i
do
    ficd $each
    pwd

done

