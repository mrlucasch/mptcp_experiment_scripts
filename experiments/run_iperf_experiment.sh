#!/bin/bash

loc="../microbenchmarks"
name=iperf_baseline
timestamp=$(date "+%Y-%m-%d_%H-%M-%S")

./record_experiment.py ${name}_${timestamp}



${loc}/./run_iperf.sh ${name}_${timestamp} 15G 1 mptcp mptcp_send
