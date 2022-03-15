

#Script to Provision your server here
	docker exec -it openssh-server bash -c "apk update pciutils"
	docker exec -it openssh-server bash -c "apk add python3"
	docker exec -it openssh-server2 bash -c "apk update pciutils"
	docker exec -it openssh-server2 bash -c "apk add python3"
	docker cp ../../config/id_rsa.pub openssh-server:/config/.ssh/authorized_keys
	docker cp ../../config/id_rsa.pub openssh-server2:/config/.ssh/authorized_keys

#above is only for docker container workspace
#Script to Provision your server here

