#!/bin/bash

#echo "Username/            Runnin         Limit Pendin
#Totals      Account    Jobs   CPUs   CPUs   Jobs   CPUs Further info
#=========== ======== ====== ====== ====== ====== ====== ============================="
#showuserjobs | grep changai

showuserjobs | sed "/changai/q"
