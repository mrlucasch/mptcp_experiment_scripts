#!/bin/bash

loc="../microbenchmarks"
result_loc=""
name=rsync_baseline
timestamp=$(date "+%Y-%m-%d_%H-%M-%S")

./record_experiment.py ${result_loc}${name}_${timestamp}



${loc}/./run_rsync.sh ${result_loc}${name}_${timestamp} 15G 1 mptcp mptcp_send
${loc}/./run_rsync.sh ${result_loc}${name}_${timestamp} 15G 2 mptcp mptcp_send
