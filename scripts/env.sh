export config_file_path="../test_files"

export credential_file=../config/id_rsa
export server_username=test
export ssh_port=2222
#export server_address="gpu-server1 gpu-server2"
#please keep the format as the exmaple below shows
export server_list="gpu-server2 gpu-server1"
export gpu_count_list="8 4"
export upload_path=/tmp
export code_file="hello.py"
export runtime_code="python3 $code_file"