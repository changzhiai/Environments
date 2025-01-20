
mq ls|grep 62|awk '{print $1}'|while read -r jobid; do mq rm -i $jobid -f; done
