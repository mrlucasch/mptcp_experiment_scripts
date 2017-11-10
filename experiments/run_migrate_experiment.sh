#!/bin/bash

loc="../migrations"
result_loc=""
name=migration_baseline
timestamp=$(date "+%Y-%m-%d_%H-%M-%S")

python ../utils/record_experiment.py ${result_loc}${name}_${timestamp}

${loc}/./run_migration.sh ${result_loc}${name}_${timestamp} 1 mptcp compile mptcp_send
${loc}/./run_migration.sh ${result_loc}${name}_${timestamp} 2 mptcp compile mptcp_send

