


workload="test2"

s1=3
s2=4

dst1=10.16.${s1}.98
dst2=10.16.${s2}.98


dst_manage=192.168.245.98
src1=10.16.${s1}.91
src2=10.16.${s2}.91


congestion1_1=10.16.${s1}.92
congestion1_2=10.16.${s2}.92
congestion2_1=10.16.${s1}.96
congestion2_2=10.16.${s2}.96

congestion1_manage=192.168.245.92
congestion2_manage=192.168.245.96


script_output_parent=$NAME

trial=5

script=/mptcp

mptcp_file=mptcp_send
tcp_file=tcp_send
cipher="aes128-gcm@openssh.com"

tcp_cubic_file=tcp_cubic
mptcp_olia_file=mptcp_olia
mptcp_balia_file=mptcp_balia
mptcp_wvegas_file=mptcp_wvegas

ycsb_location=/workspace/ycsb-0.12.0
redis_config_location=/workspace/redis-stable/redis.conf