#!/bin/bash

loc="../migrations"
result_loc=""
name=migration_58G_memory_baseline_buffer
timestamp=$(date "+%Y-%m-%d_%H-%M-%S")

python ../utils/record_experiment.py ${result_loc}${name}_${timestamp}


for i in {1..5}
do
		${loc}/./run_migration.sh ${result_loc}${name}-256mb_${timestamp} $i mptcp compile mptcp_256mb_rbuff
		${loc}/./run_migration.sh ${result_loc}${name}-256mb_${timestamp} $i tcp compile tcp_256mb_rbuff



done
