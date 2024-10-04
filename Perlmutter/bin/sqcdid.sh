#!/bin/bash

JOBID=$1

JOBDIR=$(showjob $JOBID|grep 'WorkDir'|awk -F'=' '{print $2}')

cd $JOBDIR

