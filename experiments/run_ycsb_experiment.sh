#!/bin/bash

loc="../microbenchmarks"
result_loc=""
name=ycsb_baseline
timestamp=$(date "+%Y-%m-%d_%H-%M-%S")

python ../utils/record_experiment.py ${result_loc}${name}_${timestamp}



${loc}/./run_ycsb.sh ${result_loc}${name}_${timestamp} 1 mptcp /workspace/YCSB/workloads/workload_ahmed mptcp_send
${loc}/./run_ycsb.sh ${result_loc}${name}_${timestamp} 2 mptcp /workspace/YCSB/workloads/workload_ahmed mptcp_send
