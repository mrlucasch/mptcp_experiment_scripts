#!/bin/bash



#### Useful Functions




run_ycsb(){

	
	#ycsb_workload=/workspace/YCSB/workloads/workload_ahmed
	
	ssh $dst_manage "screen -d -m redis-server $redis_config_location"
	sleep 2
	curdir=$(pwd)	
	run_mini_monitors $1

	cp $ycsb_workload $1/workload.txt
	# echo "PIDS:"
	# echo "Ifstat: $ifstat_pid"
	# echo "Running YCSB"
	echo $1
	cd $ycsb_location
    ${ycsb_location}/./bin/ycsb load redis -s -P $ycsb_workload -p "redis.host=$dst1" -p "redis.port=6379" -p "exportfile=$curdir/$script_output/${NAME}_ycsb_load.txt" &> /tmp/ycsb_load.txt
	sleep 5
    ${ycsb_location}/./bin/ycsb run redis -s -P $ycsb_workload -p "redis.host=$dst1" -p "redis.port=6379" -p "exportfile=$curdir/$script_output/${NAME}_ycsb_run.txt" &> /tmp/ycsb_run.txt
    cd $curdir
	#echo "Finished Run!"
	sleep 4

	kill_monitors
	ssh $dst_manage pkill -9 redis-server
	ssh $dst_manage "rm ~/*.rdb"
	#echo "Experiment Complete. Ouput located: $script_output/${NAME}_ycsb_run.txt"
		
}


########

## Script Workflow


NAME=$1
c=$2
protocol=$3
##Typically /workspace/YCSB/workloads/workload_ahmed
ycsb_workload=$4



###Check for usage
if [ "$#" -ne 4 ]; then
	echo "Usage:"
	echo "$0 exp_name TrialNum Protocol Workload_script"
	exit
fi

### Import environment variables
source environment_config.sh



###Import Util Functions
source util.sh


### Make parent script output
### Usually of the Form: $NAME_${timestamp}
mkdir -p $script_output_parent


## Output of script 
script_output=${script_output_parent}/${script_output_parent}_${protocol}_trial${c}

## Print Environment variables
echo "Experiment Name: " $NAME  > ${script_output}_env_variables.txt
echo "YCSB Workload: " $ycsb_workload >> ${script_output}_env_variables.txt
echo "Current Trial: " $c >> ${script_output}_env_variables.txt
echo "Protocol: "$protocol >> ${script_output}_env_variables.txt
print_environment_variables >> ${script_output}_env_variables.txt






set_environment $protocol $dst1
set_environment $protocol $src2
#echo "Configured Host"
sleep 2

run_ycsb $script_output
sleep 5







