#!/bin/bash


#/workspace/mptcp_experiment_scripts/results/migrate_baseline/migrate_baseline_mptcp_trial1/../results/migrate_baseline__migration.txt
#### Useful Functions


run_rsync(){
	bytes=$1
	run_mini_monitors $2

	echo $script_output
	(time rsync -vW --progress -e "ssh -T -c ${cipher}" /ssd/file_${bytes} $dst1:/ssd/.) &> $script_output/${script_output_parent}_rsync.txt
	kill_monitors
	ssh $dst_manage "rm -rf /ssd/file_${bytes}G"

	

}

run_migration(){

	run_mini_monitors $1

	echo $script_output
	rpath=$(readlink -f $script_output)
	cd $vm_locations
	virsh create $vm_name &>/dev/null

	sleep 15
	thresh=15G
	fill_val=16
	if [ "$vm_name" == "web60.xml" ];
	then
    	thresh=58G

		fill_val=60

	fi
	if [ "$vm_name" == "web58.xml" ];
	then
    	thresh=56G

		fill_val=58

	fi


	if [ "$vm_name" == "web32.xml" ];
	then
    	thresh=31G
		fill_val=32
	fi

	if [ "$vm_name" == "web.xml" ];
	then
    	thresh=15G
		fill_val=16
	fi


	#ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o PubkeyAuthentication=yes -o PasswordAuthentication=no $vm_login "./clean.sh" &>/dev/null
	ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o PubkeyAuthentication=yes -o PasswordAuthentication=no $vm_login screen -d -m "~/dirty_script/fill $fill_val" &>/dev/null
	#ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o PubkeyAuthentication=yes -o PasswordAuthentication=no $vm_login screen -d -m "./compile.sh" &>/dev/null


	sleep 2
	web_mem="0"
	while [ "$web_mem" != "$thresh" ];
	do
    	web_mem="$(ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o PubkeyAuthentication=yes -o PasswordAuthentication=no $vm_login free -mh | grep 'Mem:' | awk '{print $3}')"
    	#echo $web_mem
    	sleep 6
	done
	#echo "Workloads started successfully"
	sleep 2
	START=$SECONDS


	(time virsh migrate --live web qemu+tcp://${dst1}:16509/system --migrateuri tcp://${dst1}:4444) 2>>$rpath/${NAME}_migration.txt

	END=$(($SECONDS-$START))
	#echo "Final Time is ==>"$END
	echo "Final Time is ==>"$END >> $rpath/${NAME}_migration.txt

	kill_monitors
	ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no ${dst_manage} "virsh list" &>> $rpath/${NAME}_migration.txt
	ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no ${dst_manage} "virsh destroy web" &>/dev/null
	cd - >/dev/null
}



########

## Script Workflow



NAME=$1
c=$2
protocol=$3
##Typically /workspace/YCSB/workloads/workload_ahmed
vm_workload=$4


###Check for usage
if [ "$#" -ne 5 ]; then
	echo "Usage:"
	echo "$0 exp_name TrialNum Protocol vm_workload config_fname"
	exit
fi




### IMport environment variables
source ../config/environment_config.sh



config_filename=$script"/"$5

###Import Util Functions
source ../utils/util.sh


### Make parent script output
### Usually of the Form: $NAME_${timestamp}
mkdir -p $script_output_parent/configs


## Output of script 
script_output=${script_output_parent}/${NAME}_${protocol}_trial${c}
script_config_output=${script_output_parent}/configs/${NAME}_${protocol}_trial${c}
## Print Environment variables
echo "Experiment Name: " $NAME  > ${script_config_output}_env_variables.txt
echo "VM Workload: " $vm_workload >> ${script_config_output}_env_variables.txt
echo "VM Location: " $vm_locations >> ${script_config_output}_env_variables.txt
echo "VM Name: " $vm_name >> ${script_config_output}_env_variables.txt
echo "VM Login: " $vm_login >> ${script_config_output}_env_variables.txt
echo "Current Trial: " $c >> ${script_config_output}_env_variables.txt
echo "Protocol: "$protocol >> ${script_config_output}_env_variables.txt
print_environment_variables >> ${script_config_output}_env_variables.txt



set_environment $protocol $dst1
set_environment $protocol $src2

sleep 2 

run_migration $script_output
sleep 5
