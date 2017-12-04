#!/bin/bash
scripts=/mptcp
mptcp_config=mptcp_256mb_rbuff
tcp_config=tcp_256mb_rbuff
server=obelix91
client=obelix98


if [ -z "$1" ]; then
	echo "Usage:"
	echo "$0 start trial protocol exp_name"
	echo "or"
	echo "$0 stop"
	echo "or"
	echo "$0 clean name"
	exit

fi

op=$1
source exp_data.sh

if [[ "$op" == "start" ]];then
	echo "STARTing"
	t=$2
	p=$3
	name=$4

	if [ "$#" -ne 4 ]; then
		echo "Usage:"
		echo "$0 start trial protocol exp_name"
		exit
	fi
	if [ -z $TIMESTAMP ];
	then
		TIMESTAMP=$(date "+%Y-%m-%d_%H-%M-%S")
		echo "TIMESTAMP=${TIMESTAMP}" >exp_data.sh
	fi
	
	if [[ "$p" == "mptcp" ]];then
		config=${scripts}/${mptcp_config}
	fi
	if [[ "$p" == "tcp" ]]; then
		config=${scripts}/${tcp_config}
	fi
	
	ssh $server "${scripts}/validate.py -f $config"
	ssh $client "${scripts}/validate.py -f $config"

	ssh $server "sudo service vsftpd restart"



	parent=${name}_${TIMESTAMP}
	mkdir -p $parent
	direct=${name}_${p}_trial_${t}_${TIMESTAMP}
	mkdir -p ${parent}/${direct}
	touch ${parent}/${direct}/${parent}_ftp.txt
	ssh $server "${scripts}/display_config.py " > ${parent}/${direct}/${parent}_${server}_config.txt
	ssh $client "${scripts}/display_config.py " > ${parent}/${direct}/${parent}_${client}_config.txt
	ifstat -bnt > ${parent}/${direct}/${parent}_ifstat.txt & 
	vmstat -tn 2 > ${parent}/${direct}/${parent}_vmstat.txt & 
	
	echo "Put results here: ${parent}/${direct}/${parent}_ftp.txt"
fi

if [[ "$op" == "stop" ]]; then
	echo "Stopping"
	sudo pkill -15 ifstat
	sudo pkill -15 vmstat
	
	ps -ef | grep vmstat
	ps -ef | grep ifstat
fi


if [[ "$op" == "clean" ]]; then
	echo "cleaning"
	if [ "$#" -ne 2 ];then
		echo "Usage:"
		echo "$0 clean dir_name"
		exit
	fi
	name=$2
	rm -rf exp_data.sh
	zip -r ${name}_${TIMESTAMP}.zip ${name}_${TIMESTAMP}
	echo "Results are here:" ${name}_${TIMESTAMP}.zip
fi





