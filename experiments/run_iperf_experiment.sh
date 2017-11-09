#!/bin/bash

loc="../microbenchmarks"
result_loc=""
name=iperf_baseline
timestamp=$(date "+%Y-%m-%d_%H-%M-%S")

python ../utils/record_experiment.py ${result_loc}${name}_${timestamp}



${loc}/./run_iperf.sh ${result_loc}${name}_${timestamp} 15G 1 mptcp mptcp_send
${loc}/./run_iperf.sh ${result_loc}${name}_${timestamp} 15G 2 mptcp mptcp_send
