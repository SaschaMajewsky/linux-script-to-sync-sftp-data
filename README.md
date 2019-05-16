# linux-script-to-sync-sftp-data

A small linux script that is used at work to automate folder synchronization between a remote server of our phone recordings and our local write-once-read-many regulatory medium.

## The Story Behind The Project

As to regulatory requirements our company has to record all of it's telephone call and protocols daily and needs to persist the data with an immutable ledger or datastorage device. This is why we chose to use a Tandberg RDX for persisting the data in a software-level WORM device that does not allow manipulation or deletion of files. These devices only have drivers for Windows and only reliable work under it. On the other side all of the telephone data is provided by the company of the telephones at the office. It is accessible the easiest by Linux via sftp through ssh public/private key pairs. To get this requirements matched I developed our own automated solution that accesses the remot server through ubuntu commands each night and copies the content of the recordings to our WORM-drive attatched to another Windows server. Thus the server is in the same local network as the Linux host folders can be accesses through the local network an be mounted into Linux. Also just for safety there is another automated process running under Linux that takes the saved recordings in the WORM-device and syncs that to a normal directory on the Windows server. For the automation of the command line commands for connecting with the server etc the tool Expect was used and for the scheduling crontab was used.

## Getting Started

Follow the Prerequisites and Installing sections.

### Prerequisites

What things you need to install the software and how to install them

```
Ubuntu 18.04
Expect
Have a windows machine in local network
Have a write-once-read-many (WORM) device
Have a SSH private key for establishing the connection (the remote server needs to know your public key already)
```

### Installing

A step by step series of examples that tell you how to get a development env running

Say what the step will be

```
Install Ubuntu

Update Ubuntu with
sudo apt update && sudo apt upgrade

Install Expect:
apt-get install expect

Move into the directory of Expect and set the access rights:
cd /usr/bin/
sudo chmod 755 expect

Create a folder at a path of your choosing where the scripts should be contained:
mkdir telephone
cd telephone

Place the scripts into the folder and also your private key for your SSH connection

To get the WORM-device connected to a local Windows machine mounted into your Linux system do this:
On the WORM-Drive create a folder where the recordings should be saved
Rightclick the directory and create a "share" permission for a certain user/group you will get a URL to access it.
Find out which ip-address the windows machine has in your local network (192.168.178.xxx)
Go into the Ubuntu directory /mnt/ and create a new folder that will later on be mounted/mapped to the windows shared folder
Mount the drive in Ubuntu by using
sudo mount -t cifs -user=xxx_windows_admin_username //192.168.178.xxx_windows_local_ip/xxx_shared_folder_path /mnt/xxx_name_of_chosen_folder_to_map_windows_WORM_folder

Check if you mounted the drive correctly by placing a random file into it via Linux or Windows and check on both devices if it is visible. You might need to set permission rights on Ubuntu with applying this command to the mounted folder
cd /mnt/
sudo chmod 755 xxx_mounted_folder_name

Open the scripts provided in this project under /scripts/ and change all the variables starting with xxx to your passwords, pathes, serveradresses etc

Then change into the directories containing your scripts and give them execution permissions:
sudo chmod u+x xxx_scriptname1
sudo chmod u+x xxx_scriptname2

Now everything should be setup and you can invoke the scripts by:
cd /xxx_path_containing_scripts/
./xxx_scriptname1
./xxx_scriptname2

Check the result in the mounted folder, all files from the remote server accessed through sftp and SSH should be now in your windows WORM-drive. Except allowed us to automate the whole process of speaking to the server and requesting its files. Yay!

But executing this process by hand is still not satisfying that is why a crontab has be made to automate the whole process even further. This can be done like this:
sudo -i
crontab -e
1

Now you should be with nano (command-line text editor) in a crontab file. Scroll down the the arrow keys until you reach the end to the file and add: (Read up on how to set the times for the crontab this example will invoke the script1 daily at 02:01 in the night and script2 at 03:01 in the night.)
01 02 * * * xxx_path_to_script1
01 03 * * * xxx_path_to_script2

Then press CTRL + X Then Y and then ENTER.
Fulfilling regulatory aspects like having an automated process that handles office phone recordings and persists them immutable was never easier.
```

## Authors

* **Sascha Majewsky**