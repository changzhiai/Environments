#!/bin/bash

#export SQUEUE_FORMAT="%.18i %.9P %.26j %.8u %.10T %.9Q %.10M %.9l %.6D %.6C %R"

sq.sh|sed -n '2,$p' | while read line; do id=$(echo $line|awk '{print $1}');name=$(echo $line|awk '{print $3}');state=$(echo $line|awk '{print $5}');times=$(echo $line|awk '{print $7}');cpus=$(echo $line|awk '{print $10}'); dir=$(sacct -j $id -nP -o WorkDir | head -1|sed 's\/global/homes/c/changzhi\~\g'); printf '%8s %-26s %8s %10s %3s %s/\n' $id $name $state $times $cpus $dir; done


#sq.sh|sed -n '2,$p' | while read line; do id=$(echo $line|awk '{print $1}');name=$(echo $line|awk '{print $3}');state=$(echo $line|awk '{print $5}');times=$(echo $line|awk '{print $7}');cpus=$(echo $line|awk '{print $10}');dir=$(showjob $id|grep 'WorkDir'|awk -F'=' '{print $2}'|sed 's\/global/homes/c/changzhi\~\g'); printf '%8s %-26s %8s %10s %3s %s/\n' $id $name $state $times $cpus $dir; done

export SQUEUE_FORMAT="%.18i %.9P %.8j %.8u %.10T %.9Q %.10M %.9l %.6D %.6C %R"

#sq|sed -n '2,$p' | while read line; do id=$(echo $line|awk '{print $1}');name=$(echo $line|awk '{print $3}');state=$(echo $line|awk '{print $5}');cpus=$(echo $line|awk '{print $10}');dir=$(showjob $id|grep 'WorkDir'|awk -F'=' '{print $2}'); printf '%8s %12s %8s %3s %s\n' $id $name $state $cpus $dir; done
