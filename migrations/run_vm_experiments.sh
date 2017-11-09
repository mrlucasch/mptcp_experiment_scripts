#!/bin/bash

timestamp=$(date "+%Y-%m-%d_%H-%M-%S")
name=vm_migrations_baseline_10gig_plain_tcp

/workspace/mptcp-datacenters/experiments/scripts/record_experiment.py ${name}_${timestamp}

mv /workspace/mptcp-datacenters/experiments/scripts/${name}_${timestamp} . 

for i in {1..10}
do
 # your-unix-command-here
	./migrate.sh ${name}_${timestamp} mptcp $i
	sleep 2
	./migrate.sh ${name}_${timestamp} tcp $i
	sleep 2

 echo $i
done



#./migrate.sh ${name}_${timestamp} mptcp 1 
#sleep 2
#./migrate.sh ${name}_${timestamp} tcp 1 
#sleep 2
#./migrate.sh ${name}_${timestamp} mptcp 2 
#sleep 2
#./migrate.sh ${name}_${timestamp} tcp 2 

#sleep 2
#./migrate.sh ${name}_${timestamp} mptcp 3 
#sleep 2
#./migrate.sh ${name}_${timestamp} tcp 3 

#sleep 2
#./migrate.sh ${name}_${timestamp} mptcp 4 
#sleep 2
#
#./migrate.sh ${name}_${timestamp} tcp 4 

#sleep 2
#
#./migrate.sh ${name}_${timestamp} mptcp 5 

#sleep 2
#./migrate.sh ${name}_${timestamp} tcp 5 

