#!/bin/bash

source ../config/environment_config.sh

fill_val=30
thresh=30G

#sudo cgexec -g net_cls:experiment sudo libvirtd -d

cd $vm_locations
virsh create $vm_name #&>/dev/null
sleep 10

##1gbit experimetn
#virsh migrate-setspeed web --bandwidth 125  ## 1gbit
#virsh migrate-setspeed web --bandwidth 250  ## 2gbit

##2git experiment
#virsh migrate-setspeed web --bandwidth 250  ## 2gbit
#virsh migrate-setspeed web --bandwidth 500  ## 4gbit


## 4gbit experiment
#virsh migrate-setspeed web --bandwidth 500  ## 4gbit
#virsh migrate-setspeed web --bandwidth 1000 ## 8gbit

##8gbit experiment
#virsh migrate-setspeed web --bandwidth 1000 ## 8gbit
#virsh migrate-setspeed web --bandwidth 2000 ## 16gbit

##10gbit experiment
virsh migrate-setspeed web --bandwidth 1250 ## 10gbit
#virsh migrate-setspeed web --bandwidth 2500 ## 20gbit 

echo "-------Bandwidth now--------------"
virsh migrate-getspeed web 
echo "----------------------------------"
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o PubkeyAuthentication=yes -o PasswordAuthentication=no $vm_login screen -d -m "~/dirty_script/fill $fill_val" &>/dev/null

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


#time virsh migrate --live web qemu+tcp://${dst1}:16509/system --migrateuri tcp://${dst1}:4444 #) 2>>$rpath/${NAME}_migration.txt
time sudo cgexec -g net_cls:experiment virsh migrate --verbose --live web qemu+tcp://${dst1}:16509/system --migrateuri tcp://${dst1}:4444 #) 2>>$rpath/${NAME}_migration.txt

END=$(($SECONDS-$START))
#echo "Final Time is ==>"$END
echo "Final Time is ==>"$END #>> $rpath/${NAME}_migration.txt

#sudo pkill -15 dstat
#kill_monitors
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no lucas@${dst_manage} "virsh list" #&>> $rpath/${NAME}_migration.txt
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no lucas@${dst_manage} "virsh destroy web" #&>/dev/null
