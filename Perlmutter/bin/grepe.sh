#!/bin/bash

line=$(grep "energy without" OUTCAR|tail -1|awk '{print $8}')

echo $line
