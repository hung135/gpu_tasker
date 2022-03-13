show_process:
	ssh -i ./config/.ssh/id_rsa test@openssh-server -p 2222 ps aux | grep hello | wc -l

kill_all:
	ssh -i ./config/.ssh/id_rsa test@openssh-server -p 2222 pkill -9 python3

upload_code:
	scp -i ./config/.ssh/id_rsa -P 2222 hello.py test@openssh-server:~/ 
download_output:
	echo "SSH somewhere"
run_code: upload_code
	ssh -i ./config/.ssh/id_rsa test@openssh-server -p 2222 nohup python3 hello.py &
	$(MAKE) show_process
sshkey:
	docker run --rm -it --entrypoint /keygen.sh linuxserver/openssh-server >./config/keys.txt
	mkdir ./config/.ssh/
split_sshkey:
	tail -n 13 ./config/keys.txt | head -n 12>./config/.ssh/id_rsa
	 
	tail -n 1 ./config/keys.txt > ./config/.ssh/id_rsa.pub
	 
ssh:
	ssh -i ./config/.ssh/id_rsa test@openssh-server -p 2222
run: provision reset_test_files
	cd scripts && bash run.sh
watch: 
	cd scripts && bash watch.sh

provision:
	docker exec -it openssh-server bash -c "apk update pciutils"
	docker exec -it openssh-server bash -c "apk add python3"
	docker exec -it openssh-server2 bash -c "apk update pciutils"
	docker exec -it openssh-server2 bash -c "apk add python3"

reset_test_files:
	mv test_files/completed/* test_files/