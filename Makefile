.PHONY: test_files
show_process:
	ssh -i ./config/id_rsa test@openssh-server -p 2222 ps aux | grep hello | wc -l

kill_all:
	ssh -i ./config/id_rsa test@openssh-server -p 2222 pkill -9 python3

upload_code:

download_output:
	echo "SSH somewhere"
run_code: upload_code
	ssh -i ./config/id_rsa test@openssh-server -p 2222 nohup python3 hello.py &
	$(MAKE) show_process
sshkey:
	

	@mkdir ./config/ || true 
	@echo "Just hit ENTER ENTER"
	@ssh-keygen -f ./config/id_rsa 
	@chmod 0600 ./config/id_rsa
	@chmod 0644 ./config/id_rsa.pub
	@echo "PLEASE Prune All Containers and Rebuild"
	

	 
ssh:
	ssh -i ./config/id_rsa test@openssh-server -p 2222
run: reset_test_files upload_code
	cd scripts && bash run.sh
watch: 
	cd scripts && bash watch.sh

provision: sshkey
	cd scripts/target_prj && bash provision.sh

test_files:
	cd scripts &&\
	bash test_gen.sh
reset_test_files:
	mkdir -p test_files/completed/ || true
	mv test_files/completed/* test_files/ || true