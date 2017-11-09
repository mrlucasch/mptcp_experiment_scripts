#!/bin/bash

#src=obelix91
src=10.16.3.91
#dst=obelix98
dst=10.16.3.98
src_manage=192.168.245.91
dst_manage=192.168.245.98
protocol=$2
trial=$3
output_name=$1
#mptcp_config=mptcp_config_cubic
#mptcp_config=mptcp_config
#tcp_config=tcp_config
mptcp_config=mptcp_send
tcp_config=tcp_send

config=${mptcp_config}
script=/mptcp
###Configure protocol
if [ "$protocol" == "mptcp" ]; then
	config=$script"/$mptcp_config"
fi
if [ "$protocol" == "tcp" ]; then
	config=$script"/$tcp_config"
fi

mkdir -p $output_name
output_script=${output_name}/${output_name}_${protocol}_trial${trial}
ssh ${src_manage} "/mptcp/./validate.py -f ${config}"
ssh ${dst_manage} "/mptcp/./validate.py -f ${config}"

ssh ${src_manage} "/mptcp/./display_config.py" > ${output_name}/${src}_${protocol}_trial-${trial}_config.txt 
ssh ${dst_manage} "/mptcp/./display_config.py" > ${output_name}/${dst}_${protocol}_trial-${trial}_config.txt 


sleep 5 
flush_tcp_cache
flush_cache

sudo ifstat -bnt > ${output_script}_ifstat.txt &
ifstat_pid=$!

sudo vmstat -tn 2 > ${output_script}_vmstat.txt &
vmstat_pid=$!

#virsh migrate --live web qemu+ssh://dest1/system
virsh create web.xml

sleep 10

ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no ubuntu@web "./clean.sh"
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no ubuntu@web screen -d -m "~/dirty_script/fill 15"
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no ubuntu@web screen -d -m "./compile.sh"
#ssh ubuntu@web screen -d -m "~/dirty_script/./fill2 16"


#web_mem="0G"
#while [ "$web_mem" != "15G" ];
#do
#	web_mem="$(ssh ubuntu@web free -mh | grep 'Mem:' | awk '{print $3}')"
#	echo "web_mem ==> "$web_mem
#	sleep 5
#done
sleep 5
echo "Workloads started successfully"


START=$SECONDS
#(time virsh migrate --live web qemu+ssh://${dst}/system --migrateuri tcp://${dst}:4444) 2>>${output_script}_migration.out
#(time virsh migrate --live web qemu+ssh://${dst}/system --migrateuri tcp://${dst}:4444) 2>>${output_script}_migration.out
(time virsh migrate --live web qemu+tcp://${dst}:16509/system --migrateuri tcp://${dst}:4444) 2>>${output_script}_migration.out

#virsh migrate --live web --desturi tcp://dest1:4444
END=$(($SECONDS-$START))
echo "Final Time is ==>"$END
echo "Final Time is ==>"$END >> ${output_script}_migration.out

sudo kill -15 $ifstat_pid
sudo pkill -15 ifstat
sudo kill -15 $vmstat_pid
sudo pkill -15 vmstat


ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no ${dst_manage} "virsh destroy web"
