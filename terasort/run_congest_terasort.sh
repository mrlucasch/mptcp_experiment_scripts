#!/bin/bash

machines="obelix91 obelix92 obelix93 obelix94 obelix95 obelix96 obelix97 obelix98"
protocols="mptcp tcp"
mptcp_config="/mptcp/mptcp_config"
tcp_config="/mptcp/tcp_config"
trials="1 2 3 4 5 6 7 8 9 10"
#trials="1"
#trials="1 2 3 4 5"
#trials="1"
name="full_congestion"
timestamp=$(date "+%Y-%m-%d_%H-%M-%S")
for trial in $trials; do
	for protocol in $protocols; do
		if [ $protocol == "mptcp" ];then
			config=$mptcp_config
		fi
		if [ $protocol == "tcp" ]; then
			config=$tcp_config
		fi
		for machine in $machines; do 
			ssh $machine "validate.py -f $config"
			ssh $machine "sudo /sbin/sysctl -w vm.drop_caches=3"
		done
		start-dfs.sh
		start-master.sh
		start-slaves.sh
		sleep 5
		./run_terasort.sh sort ${name}_${timestamp}_${protocol}_trial${trial}
		sleep 5	
		stop-slaves.sh
		stop-master.sh
		stop-dfs.sh
	done
	
done

clear 
echo "Output ID is: ${name}_${timestamp}_(MPTCP|TCP)_trial(1|2|3|4|5|6|7|8|9|10)"
