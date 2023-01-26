#!/bin/bash

id=$1

if [[ $id =~ ^[0-9]+$ ]]
then
    JOBDIR=$(showjob $id|grep 'WorkDir'|awk -F'=' '{print $2}')
else
    jobid=$(sq|grep $id|awk '{print $1}')
    JOBDIR=$(showjob $jobid|grep 'WorkDir'|awk -F'=' '{print $2}')
fi


cd $JOBDIR

