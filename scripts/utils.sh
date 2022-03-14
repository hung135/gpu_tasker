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
            get_next_avail
            echo "Next GPU" $next_gpu_num
            sleep 2
            clear
    done
}

gpu_server=0
next_gpu_num=0

get_next_avail(){
     
    busy_gpu_count=0
    total_gpu_count=0
    for server in $server_list
    do
        let "total_gpu_count+=gpu_count"
        for (( i=0; i<$gpu_count; i++ ))
        do
            xx=$(ssh -i $credential_file $server_username@$server -p $ssh_port ps aux | grep "gpu $i" | wc -l)
            if [ "$xx" -eq "0" ]
            then
                 
                gpu_server=$server
                break
            fi
           let "busy_gpu_count+=1"
        done
        if [ "$xx" -eq "0" ]; then  break; fi
         
    done
     
    if [ "$busy_gpu_count" -ge "$total_gpu_count" ]; then let "next_gpu_num=99";  else let "next_gpu_num=$i";  fi
    
    
}
run_code(){
  
    #echo ssh -i $credential_file $server_username@$1 -p $ssh_port nohup python3 hello.py --gpu $2 $3 $4 &
    ssh -i $credential_file $server_username@$1 -p $ssh_port nohup python3 hello.py --gpu $2 $3 $4 &
}