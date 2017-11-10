#!/bin/bash



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

	sleep 10
	ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $vm_login "./clean.sh" &>/dev/null
	ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $vm_login screen -d -m "~/dirty_script/fill 15" &>/dev/null
	ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $vm_login screen -d -m "./compile.sh" &>/dev/null


	sleep 5
	#echo "Workloads started successfully"

	START=$SECONDS


	(time virsh migrate --live web qemu+tcp://${dst1}:16509/system --migrateuri tcp://${dst1}:4444) 2>>$rpath/${NAME}_migration.txt

	END=$(($SECONDS-$START))
	echo "Final Time is ==>"$END
	echo "Final Time is ==>"$END >> $rpath/${script_output_parent}__migration.txt

	kill_monitors
	ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no ${dst_manage} "virsh list" &>> $rpath/${NAME}_migration.txt
	ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no ${dst_manage} "virsh destroy web"
	cd - 
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
