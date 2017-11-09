



print_environment_variables(){

	#echo "Experiment Name: " $NAME 
	echo "Subnet1: " $s1
	echo "Subnet2: " $s2
	echo "Destination1: " $dst1
	echo "Destination2: " $dst2
	echo "Destination Manage: " $dst_manage
	echo "Source1: " $src1
	echo "Source2: "$src2
	echo "Congestion1_1 : "$congestion1_1
	echo "Congestion1_2 : "$congestion1_2
	echo "Congestion2_1 : "$congestion2_1
	echo "Congestion2_2 : "$congestion2_2
	echo "Congestion1_manage : "$congestion1_manage
	echo "Congestion2_manage : "$congestion2_manage
	echo "Script_output_parent : "$script_output_parent
	echo "Trials: "$trial
	echo "Script Locations: "$script
	echo "MPTCP File: "$mptcp_file
	echo "TCP File: "$tcp_file
	echo "TCP Cubic File: "$tcp_cubic_file
	echo "MPTCP Olia File: "$mptcp_olia_file
	echo "MPTCP Balia File: "$mptcp_balia_file
	echo "MPTCP Wvegas File: "$mptcp_wvegas_file
	echo "Cipher: "$cipher

}


run_mini_monitors(){

	script_output=$1
	mkdir -p $script_output
	date > $script_output/timestamp	

	flush_tcp_cache
	flush_cache



	sudo ifstat -bnt > $script_output/${NAME}_ifstat.txt &
	ifstat_pid=$!

	sudo vmstat -tn 2 > $script_output/${NAME}_vmstat.txt &
	vmstat_pid=$!

	# ss2 2 $src1 > $script_output/${NAME}_p1_ss.txt &
	# ss1_pid=$!

	# ss2 2 $src2 > $script_output/${NAME}_p2_ss.txt &
	# ss2_pid=$!



}



kill_monitors(){
	sudo kill -15 $ifstat_pid
	sudo pkill -15 ifstat
	sudo kill -15 $vmstat_pid
	sudo pkill -15 vmstat
	# sudo kill -15 $ss1_pid
	# sudo kill -15 $ss2_pid
	# sudo pkill -15 ss2
}



set_environment(){
	proto=$1
	hname=$2
	#check which configuration file to use
	if [ "$proto" == "mptcp" ]; then
		config_filename=$script"/$mptcp_file"
	fi
	if [ "$proto" == "tcp" ]; then
		config_filename=$script"/$tcp_file"
	fi
	if [ "$proto" == "tcp_cubic" ]; then
		config_filename=$script"/$tcp_cubic_file"
	fi
	if [ "$proto" == "mptcp_olia" ]; then
		config_filename=$script"/$mptcp_olia_file"
	fi
	if [ "$proto" == "mptcp_balia" ]; then
		config_filename=$script"/$mptcp_balia_file"
	fi
	if [ "$proto" == "mptcp_wvegas" ]; then
		config_filename=$script"/$mptcp_wvegas_file"
	fi


	ssh $hname "$script/./validate.py -f $config_filename" > $script_output_parent/${hname}_${protocol}_trial${c}_validation.txt
	ssh $hame "$script/./display_config.py" > $script_output_parent/${hname}_${protocol}_trial${c}_config.txt	

}