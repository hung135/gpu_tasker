source env.sh
source utils.sh

gpu_count=$(get_gpu_count)
server_list=$(get_server_list)
  
for server in $server_list
do
    echo $server
done

watch_server_process 