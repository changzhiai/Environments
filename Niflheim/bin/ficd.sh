#!/bin/bash

id=$1

#JOBDIR=$(showjob $id|grep '\/home\/energy'); cd $dir
JOBDIR=$(showjob $id|grep '\/home\/'); cd $dir

cd $JOBDIR

