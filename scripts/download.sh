#!/usr/bin/expect
# copy only disjoint files from the remote sftp server to <destination>
# use sudo chmod u+x filename to make this file executable
set timeout 120
spawn sftp -P xxx_portnumber -i xxx_path_to_private_key xxx_server_address
expect "Enter passphrase for key 'xxx_path_to_private_key"
send "xxx_password\n"
expect "sftp>"
send "get -r -a * xxx_path_to_mounted_WORM_drive \n"
expect "sftp"
