source env.sh
source utils.sh
 
mkdir -p $config_file_path/completed/
for FILE in $config_file_path/*.json
do 
    #echo $FILE

    next_gpu=$gpu_count
    until [ "$next_gpu" -lt "$gpu_count" ]
    do
            source env.sh
            get_next_avail
            next_gpu=$next_gpu_num
            next_gpu_server=$gpu_server
            #echo $server $gpu_count $proc_count
            if [ "$next_gpu" -ge "$gpu_count" ];
            then
                echo "All GPUs too BUSY to run: $FILE"
                
            else
                echo "Running $FILE on GPU: $next_gpu $gpu_server"
                run_code $gpu_server $next_gpu $(( $RANDOM % 60 + 10 )) $FILE
                mv $FILE $config_file_path/completed/
            fi
 
        sleep 3
    done
done