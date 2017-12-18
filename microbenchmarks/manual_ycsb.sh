#!/bin/bash

source ../config/environment_config.sh
#workload=/workspace/mptcp_experiment_scripts/microbenchmarks/workloada
workload=/workspace/mptcp_experiment_scripts/microbenchmarks/workloada_larger
#outloc="/workspace/mptcp_experiment_scripts/results/ycsb_1gig_vs_10gig/workloada"
outloc="/tmp"
ycsb_location=/workspace/ycsb_timeout/YCSB
name=$1
cd $ycsb_location


#sudo cgexec -g net_cls:experiment ${ycsb_location}/./bin/ycsb load memcached -s -p "memcached.hosts=$dst1" -P $workload -p "exportfile=${outloc}/${name}_ycsb_load.txt"

#sudo cgexec -g net_cls:experiment ${ycsb_location}/./bin/ycsb run memcached -s -p "memcached.hosts=$dst1" -P $workload -p "exportfile=${outloc}/${name}_ycsb_run.txt"

sudo cgexec -g net_cls:experiment ${ycsb_location}/./bin/ycsb load redis -s -P $workload -p "redis.host=$dst1" -p "redis.port=6379" -p "exportfile=${outloc}/${name}_ycsb_load.txt"

sudo cgexec -g net_cls:experiment ${ycsb_location}/./bin/ycsb run redis -s -P $workload -p "redis.host=$dst1" -p "redis.port=6379" -p "exportfile=${outloc}/${name}_ycsb_run.txt"


sudo pkill -2 dstat 

