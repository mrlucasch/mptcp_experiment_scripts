#!/bin/bash


dev=$1
speed=$2
#Clear Settings
tc qdisc del root dev $dev

# connection settings
tc qdisc add dev $dev root handle  10:   htb default 2

#Set Rate
tc class add dev $dev parent 10:  classid 10:1  htb rate $speed


tc filter add dev $dev parent 10:  handle   1:   protocol all cgroup


mkdir -p /sys/fs/cgroup/net_cls/experiment
echo 0x00100001 >  /sys/fs/cgroup/net_cls/experiment/net_cls.classid
