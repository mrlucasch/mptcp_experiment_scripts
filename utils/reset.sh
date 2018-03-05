#!/bin/bash

echo "Before:"
ps -ef | grep ifstat

sudo pkill -9 ifstat
echo "killed!"
ps -ef | grep ifstat

echo "Before:"
ps -ef | grep vmstat


sudo pkill -9 vmstat
echo "Killed:"
ps -ef | grep vmstat

echo "Before:"
virsh list

virsh destroy web
echo "Killed:"
virsh list
