source env.sh

test_files=10
mkdir $config_file_path
create_test_files(){
  
    for f in $( gpw $1 $2)
    
    do
        touch  $config_file_path/$f.json
    done
        
    
    
} 

create_test_files 20 10