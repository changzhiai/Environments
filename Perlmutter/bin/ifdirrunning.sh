#!/bin/bash

sqls.sh > temptasklist
a=$(pwd | sed 's\/home/energy/changai\~\g')
b=$(grep -n $a temptasklist)
if [ -n "$b" ]; then
   echo 'submitted'
   echo "$b"
else
   echo 'not submitted jobs in this directory'
fi
rm temptasklist
