#!/bin/bash

mq ls|grep iter|awk '{print $1}'|while read line; do mq rm -i $line -f; done
