#!/bin/bash



#### Useful Functions



run_rsync(){
	bytes=$1
	run_mini_monitors $2

	echo $script_output
	(time rsync -vW --progress -e "ssh -T -c ${cipher}" /ssd/file_${bytes} $dst1:/ssd/.) &> $script_output/${NAME}_rsync.txt
	kill_monitors
	ssh $dst_manage "rm -rf /ssd/file_${bytes}G"



}


########

## Script Workflow


NAME=$1
bytes=$2
c=$3
protocol=$4
#config_filename=$5



###Check for usage
if [ "$#" -ne 5 ]; then
	echo "Usage:"
	echo "$0 exp_name FileSize TrialNum Protocol Config_file"
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
script_output=${script_output_parent}/${NAME}_${protocol}_${bytes}_trial${c}
script_config_output=${script_output_parent}/configs/${NAME}_${protocol}_${bytes}_trial${c}

## Print Environment variables
echo "Experiment Name: " $NAME  > ${script_config_output}_env_variables.txt
echo "File Size: " $bytes >> ${script_config_output}_env_variables.txt
echo "Current Trial: " $c >> ${script_config_output}_env_variables.txt
echo "Protocol: "$protocol >> ${script_config_output}_env_variables.txt
print_environment_variables >> ${script_config_output}_env_variables.txt






set_environment $protocol $dst1
set_environment $protocol $src2
#echo "Configured Host"
sleep 2

run_rsync $bytes $script_output
sleep 5







