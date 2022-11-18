#!/bin/bash

# - - - - - - - - - -
### *** Access Config ***
### Remove comment on commands to enable Access configurations
### Change root password
echo "root:$1" | chpasswd && echo "Setting root pass to: $1"
### Create new User
useradd -rm -d /home/player -s /bin/bash -g root -G sudo -u 1001 player 
### Change User Password
echo "player:$2" | chpasswd && echo "Setting player pass to: $2"
# - - - - - - - - - -

# - - - - - - - - - -
### *** SSH Config ***
### Remove comment on commands to enable SSH configurations 
### Configure Message of the Day
echo ' 
  ___  __    ________  ___       ___  ________  ________     ___    ___ 
 |\  \|\  \ |\   __  \|\  \     |\  \|\   __  \|\   __  \   |\  \  /  /|
 \ \  \/  /|\ \  \|\  \ \  \    \ \  \ \  \|\ /\ \  \|\  \  \ \  \/  / /
  \ \   ___  \ \   __  \ \  \    \ \  \ \   __  \ \  \\\  \  \ \    / / 
   \ \  \\ \  \ \  \ \  \ \  \____\ \  \ \  \|\  \ \  \\\  \  /     \/  
    \ \__\\ \__\ \__\ \__\ \_______\ \__\ \_______\ \_______\/  /\   \  
     \|__| \|__|\|__|\|__|\|_______|\|__|\|_______|\|_______/__/ /\ __\ 
                                  Follow the white rabbit   |__|/ \|__|
                                                                      ' > /etc/motd
### Configure SSH to run persistently
update-rc.d -f ssh remove
update-rc.d -f ssh defaults
### Backup and move default Kali Keys to new directory
cd /etc/ssh/
mkdir kali_defaults
mv ssh_host_* kali_defaults/
### Generate new SSH keys
dpkg-reconfigure openssh-server
### Disable PermitRoot Login for SSH
sed -i 's/prohibit-password/no/' sshd_config
### Start SSH server
service ssh start
### Show services status
service --status-all
# - - - - - - - - - -

# - - - - - - - - - -
### *** Language Config ***
### System wide check for new updates 
apt-get update
### Remove comment on commands to enable Language support
### Native Tools Development
# apt-get install gcc g++ make
### Install Node.js v19.x
curl -fsSL https://deb.nodesource.com/setup_19.x | bash - && sudo apt-get install -y nodejs
### Install Python
# apt -y install python python-pip python3-pip # Python 2
# apt -y install python3 python3-pip # Python 3
### Install Java
# apt -y install default-jdk
### Install Rust
# curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -y
# - - - - - - - - - -

# - - - - - - - - - -
### *** Tools Config ***
### Remove comment on commands to enable Tool installation 
### Install Netcat tool in the Box (Network Scanning)
# apt -y install netcat-traditional
### Install Nmap tool in the Box (Network Scanning)
apt -y install nmap
### Install Hashcat tool in the Box (Password Cracking)
# apt -y install hashcat
### Install John the Riper in the Box (Password Cracking)
#apt -y install john
### Install sqlmap in the Box (SQL Injection)
# apt -y install sqlmap
### Install autopsy in the Box (Forensic Browser)
# apt -y install autopsy
# - - - - - - - - - -

# - - - - - - - - - -
## *** Keep Alive Config ***
echo 'KaliBox initialized, happy hacking :) !'
## Keep Kalibox running after init.sh
tail -f /dev/null
# - - - - - - - - - -

