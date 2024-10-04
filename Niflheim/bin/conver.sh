#!/bin/bash

for each in slab-*; do cd $each; echo $each; grep "reached required" OUTCAR; grep "energy without" OUTCAR|tail -1; less OSZICAR|tail -1; cd ..; done
