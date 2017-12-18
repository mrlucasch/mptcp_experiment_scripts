#!/bin/bash

loc="../microbenchmarks"
result_loc=""
name=rsync_congestion
timestamp=$(date "+%Y-%m-%d_%H-%M-%S")

python ../utils/record_experiment.py ${result_loc}${name}-default_${timestamp}
#cp	${loc}/run_rsync.sh ${results_loc}${name}-default_${timestamp}

for i in {1..15}
do

		fsize=1G
		${loc}/./run_rsync.sh ${result_loc}${name}-default_${fsize}_${timestamp} $fsize $i mptcp mptcp_default_rbuff
		${loc}/./run_rsync.sh ${result_loc}${name}-65mb_${fsize}_${timestamp} $fsize $i mptcp mptcp_65mb_rbuff
		${loc}/./run_rsync.sh ${result_loc}${name}-256mb_${fsize}_${timestamp} $fsize $i mptcp mptcp_256mb_rbuff
		${loc}/./run_rsync.sh ${result_loc}${name}-600mb_${fsize}_${timestamp} $fsize $i mptcp mptcp_600mb_rbuff

		${loc}/./run_rsync.sh ${result_loc}${name}-default_${fsize}_${timestamp} $fsize $i tcp tcp_default_rbuff
		${loc}/./run_rsync.sh ${result_loc}${name}-65mb_${fsize}_${timestamp} $fsize $i tcp tcp_65mb_rbuff
		${loc}/./run_rsync.sh ${result_loc}${name}-256mb_${fsize}_${timestamp} $fsize $i tcp tcp_256mb_rbuff
		${loc}/./run_rsync.sh ${result_loc}${name}-600mb_${fsize}_${timestamp} $fsize $i tcp tcp_600mb_rbuff

		fsize=25G
		${loc}/./run_rsync.sh ${result_loc}${name}-default_${fsize}_${timestamp} $fsize $i mptcp mptcp_default_rbuff
		${loc}/./run_rsync.sh ${result_loc}${name}-65mb_${fsize}_${timestamp} $fsize $i mptcp mptcp_65mb_rbuff
		${loc}/./run_rsync.sh ${result_loc}${name}-256mb_${fsize}_${timestamp} $fsize $i mptcp mptcp_256mb_rbuff
		${loc}/./run_rsync.sh ${result_loc}${name}-600mb_${fsize}_${timestamp} $fsize $i mptcp mptcp_600mb_rbuff

		${loc}/./run_rsync.sh ${result_loc}${name}-default_${fsize}_${timestamp} $fsize $i tcp tcp_default_rbuff
		${loc}/./run_rsync.sh ${result_loc}${name}-65mb_${fsize}_${timestamp} $fsize $i tcp tcp_65mb_rbuff
		${loc}/./run_rsync.sh ${result_loc}${name}-256mb_${fsize}_${timestamp} $fsize $i tcp tcp_256mb_rbuff
		${loc}/./run_rsync.sh ${result_loc}${name}-600mb_${fsize}_${timestamp} $fsize $i tcp tcp_600mb_rbuff


		fsize=75G
		${loc}/./run_rsync.sh ${result_loc}${name}-default_${fsize}_${timestamp} $fsize $i mptcp mptcp_default_rbuff
		${loc}/./run_rsync.sh ${result_loc}${name}-65mb_${fsize}_${timestamp} $fsize $i mptcp mptcp_65mb_rbuff
		${loc}/./run_rsync.sh ${result_loc}${name}-256mb_${fsize}_${timestamp} $fsize $i mptcp mptcp_256mb_rbuff
		${loc}/./run_rsync.sh ${result_loc}${name}-600mb_${fsize}_${timestamp} $fsize $i mptcp mptcp_600mb_rbuff

		${loc}/./run_rsync.sh ${result_loc}${name}-default_${fsize}_${timestamp} $fsize $i tcp tcp_default_rbuff
		${loc}/./run_rsync.sh ${result_loc}${name}-65mb_${fsize}_${timestamp} $fsize $i tcp tcp_65mb_rbuff
		${loc}/./run_rsync.sh ${result_loc}${name}-256mb_${fsize}_${timestamp} $fsize $i tcp tcp_256mb_rbuff
		${loc}/./run_rsync.sh ${result_loc}${name}-600mb_${fsize}_${timestamp} $fsize $i tcp tcp_600mb_rbuff



#
#		${loc}/./run_rsync.sh ${result_loc}${name}-default_${timestamp} 150G $i mptcp mptcp_default_rbuff
#		${loc}/./run_rsync.sh ${result_loc}${name}-65mb_${timestamp} 150G $i mptcp mptcp_65mb_rbuff
#		${loc}/./run_rsync.sh ${result_loc}${name}-256mb_${timestamp} 150G $i mptcp mptcp_256mb_rbuff
#		${loc}/./run_rsync.sh ${result_loc}${name}-600mb_${timestamp} 150G $i mptcp mptcp_600mb_rbuff
#		${loc}/./run_rsync.sh ${result_loc}${name}-600mb-600mb_${timestamp} 150G $i mptcp mptcp_600mb_rbuff_constant

#		${loc}/./run_rsync.sh ${result_loc}${name}-default_${timestamp} 150G $i tcp tcp_default_rbuff
#		${loc}/./run_rsync.sh ${result_loc}${name}-65mb_${timestamp} 150G $i tcp tcp_65mb_rbuff
#		${loc}/./run_rsync.sh ${result_loc}${name}-256mb_${timestamp} 150G $i tcp tcp_256mb_rbuff
#		${loc}/./run_rsync.sh ${result_loc}${name}-600mb_${timestamp} 150G $i tcp tcp_600mb_rbuff
#		${loc}/./run_rsync.sh ${result_loc}${name}-600mb-600mb_${timestamp} 150G $i tcp tcp_600mb_rbuff_constant

done

#		${loc}/./run_rsync.sh ${result_loc}${name}-600mb_${timestamp} 150G 1 mptcp mptcp_600mb_rbuff
