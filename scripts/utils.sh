get_gpu_count() {
    
   #echo $(ssh -i ../config/.ssh/id_rsa test@openssh-server -p 2222 lspci | wc -l)
   echo 8
}

get_server_list() {
   echo "openssh-server"
}

get_server_process(){
   echo $(ssh -i ../config/.ssh/id_rsa test@openssh-server -p 2222 ps aux | grep hello | wc -l)

}
watch_server_process(){
    while true
    do
        clear
        ssh -i ../config/.ssh/id_rsa test@openssh-server -p 2222 ps -ef | grep hello
        echo $(get_server_process)
        get_next_avail
        sleep 2
    done
}
get_next_avail(){
    for i in 0 1 2 3 4 5 6 7 99
    do
         xx=$(ssh -i ../config/.ssh/id_rsa test@openssh-server -p 2222 ps aux | grep "gpu $i" | wc -l)
         if [ "$xx" -eq "0" ]
         then
            break
         fi
    done
    echo $i
    
}
run_code(){
    ssh -i ../config/.ssh/id_rsa test@openssh-server -p 2222 nohup python3 hello.py --gpu $1 $2 $3 &
}