#!/bin/bash

#~/bin/sq.sh| awk '{print $1}'|sed -n '2,$p'
#~/bin/sq.sh| awk '{print $1}'|sed -n '2,$p'| while read i;do ~/bin/sqcd.sh $i; echo $i; cd relax; grepr; done
#sq| awk '{print $1}'|sed -n '2,$p'| while read i;do sqcd $i; echo $i; cd relax; grepr; done
#~/bin/sq.sh| awk '{print $1}'|sed -n '2,$p'| while read i;do ~/bin/sqcd.sh $i; echo $i; ls; done

sq|grep RUN
