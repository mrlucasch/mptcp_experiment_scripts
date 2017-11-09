#!/bin/bash

loc="../microbenchmarks"
name=ycsb_baseline
timestamp=$(date "+%Y-%m-%d_%H-%M-%S")

./record_experiment.py ${name}_${timestamp}



${loc}/./run_ycsb.sh ${name}_${timestamp} 1 mptcp /workspace/YCSB/workloads/workload_ahmed mptcp_send
