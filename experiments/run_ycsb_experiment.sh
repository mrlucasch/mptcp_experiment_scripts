#!/bin/bash

loc="../microbenchmarks"
result_loc=""
name=ycsb_congestion_tcp_100kb
timestamp=$(date "+%Y-%m-%d_%H-%M-%S")

python ../utils/record_experiment.py ${result_loc}${name}_${timestamp}

for i in {1..15}
do

		workload=/workspace/mptcp_experiment_scripts/microbenchmarks/workload_100kb
		#${loc}/./run_ycsb.sh ${result_loc}${name}_buffer-256mb_workload-100kb_${timestamp} $i mptcp $workload mptcp_256mb_rbuff
		${loc}/./run_ycsb.sh ${result_loc}${name}_buffer-256mb_workload-100kb_${timestamp} $i tcp $workload tcp_256mb_rbuff


		#workload=/workspace/mptcp_experiment_scripts/microbenchmarks/workload_1kb
		#${loc}/./run_ycsb.sh ${result_loc}${name}_buffer-256mb_workload-1kb_${timestamp} $i mptcp $workload mptcp_256mb_rbuff
		#${loc}/./run_ycsb.sh ${result_loc}${name}_buffer-256mb_workload-1kb_${timestamp} $i tcp $workload tcp_256mb_rbuff


		#workload=/workspace/mptcp_experiment_scripts/microbenchmarks/workloada
		#${loc}/./run_ycsb.sh ${result_loc}${name}_buffer-256mb_workloada_${timestamp} $i mptcp $workload mptcp_256mb_rbuff
		#${loc}/./run_ycsb.sh ${result_loc}${name}_buffer-256mb_workloada_${timestamp} $i tcp $workload tcp_256mb_rbuff

		workload=/workspace/mptcp_experiment_scripts/microbenchmarks/workload_100kb
		${loc}/./run_ycsb.sh ${result_loc}${name}_buffer-default_workload-100kb_${timestamp} $i mptcp $workload mptcp_default_rbuff
		${loc}/./run_ycsb.sh ${result_loc}${name}_buffer-default_workload-100kb_${timestamp} $i tcp $workload tcp_default_rbuff


		#workload=/workspace/mptcp_experiment_scripts/microbenchmarks/workload_1kb
		#${loc}/./run_ycsb.sh ${result_loc}${name}_buffer-default_workload-1kb_${timestamp} $i mptcp $workload mptcp_default_rbuff
		#${loc}/./run_ycsb.sh ${result_loc}${name}_buffer-default_workload-1kb_${timestamp} $i tcp $workload tcp_default_rbuff


		#workload=/workspace/mptcp_experiment_scripts/microbenchmarks/workloada
		#${loc}/./run_ycsb.sh ${result_loc}${name}_buffer-default_workloada_${timestamp} $i mptcp $workload mptcp_default_rbuff
		#${loc}/./run_ycsb.sh ${result_loc}${name}_buffer-default_workloada_${timestamp} $i tcp $workload tcp_default_rbuff


done
