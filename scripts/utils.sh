get_gpu_count() {
    
   #echo $(ssh -i $credential_file $server_username@$1  -p $ssh_port lspci | wc -l)
   echo $gpu_count
}

get_server_list() {
   echo "openssh-server"
}

get_server_process(){
   echo $(ssh -i $credential_file $server_username@$1 -p $ssh_port ps aux | grep hello | wc -l)

}
watch_server_process(){
    while true
    do
        for server in $server_list
        do
            
            echo $server
            ssh -i $credential_file $server_username@$server -p $ssh_port ps -ef | grep hello
            echo $(get_server_process $server)
            # get_next_avail
            
        done
            sleep 2
            clear
    done
}

gpu_server=0
next_gpu_num=0

get_next_avail(){
     
    for (( i=0; i<$gpu_count; i++ ))
    do
        for server in $server_list
        do
            xx=$(ssh -i $credential_file $server_username@$server -p $ssh_port ps aux | grep "gpu $i" | wc -l)
            if [ "$xx" -eq "0" ]
            then
                echo "breaking    $server $i"
                gpu_server=$server
                break
            fi
        done
        if [ "$xx" -eq "0" ]
        then
            break
        fi
    done
    next_gpu_num=$i
    
}
run_code(){
 
    #echo $1 $credential_file $server_username@$1 -p $ssh_port
    ssh -i $credential_file $server_username@$1 -p $ssh_port nohup python3 hello.py --gpu $2 $3 $4 &
}