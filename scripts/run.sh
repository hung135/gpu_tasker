source env.sh
source utils.sh

gpu_count=$(get_gpu_count)
server_list=$(get_server_list)
gpu_idx=0

for FILE in ../test_files/*.json
do 
    #echo $FILE

    next_gpu=99
    until [ "$next_gpu" -lt "99" ]
    do
 
            next_gpu=$(get_next_avail)
            #echo $server $gpu_count $proc_count
            if [ "$next_gpu" -eq "99" ];
            then
                echo "Totally Booked"
                
            else
                echo "running $FILE"
                run_code $next_gpu $(( $RANDOM % 60 + 5 )) $FILE
                
            
            fi
 
        sleep 3
    done
done