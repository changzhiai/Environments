#!/bin/bash

sqls.sh > temptasklist
a=$(pwd | sed 's\/home/energy/changai\~\g')/
b=$(grep $a temptasklist)
if [ -n "$b" ]; then
   echo 'submitted'
   echo $b
else
   echo 'not submitted'
fi
rm temptasklist
