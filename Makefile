show_process:
	ssh -i ./config/.ssh/id_rsa test@openssh-server -p 2222 ps aux | grep hello | wc -l
	
upload_code:
	scp -i ./config/.ssh/id_rsa -P 2222 hello.py test@openssh-server:~/ 
download_output:
	echo "SSH somewhere"
run_code: upload_code
	ssh -i ./config/.ssh/id_rsa test@openssh-server -p 2222 nohup python3 hello.py &
	$(make) show_process
sshkey:
	docker run --rm -it --entrypoint /keygen.sh linuxserver/openssh-server >./config/keys.txt
	mkdir ./config/.ssh/
split_sshkey:
	tail -n 13 ./config/keys.txt | head -n 12>./config/.ssh/id_rsa
	 
	tail -n 1 ./config/keys.txt > ./config/.ssh/id_rsa.pub
	 
ssh:
	ssh -i ./config/.ssh/id_rsa test@openssh-server -p 2222
 

provision:
	docker exec -it openssh-server bash -c "apk update"
	docker exec -it openssh-server bash -c "apk add python3"

