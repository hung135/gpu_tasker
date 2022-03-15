


#Script to Upload code your server here
for server in $server_list
do	
	. ../env.sh && scp -i ../$credential_file -P 2222 $code_file $server_username@$server: 
done
#above is only for docker container workspace
#Script to upload your server here

