#!/bin/bash
START_TIME=$(date +%s)

# - - - - - - - - - -
### *** Access Config ***
echo "[*] Access Configuration Setup"
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
echo "[*] SSH Configuration Setup"
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
echo "[*] Language Configuration Setup"
### System wide check for new updates 
apt-get update
### Remove comment on commands to enable Language support
# *
### Native Tools Development
# apt-get install gcc g++ make
# *
### Install Node.js v19.x
curl -fsSL https://deb.nodesource.com/setup_19.x | bash - && sudo apt-get install -y nodejs
# *
### Install Python
# apt -y install python python-pip python3-pip # Python 2
# apt -y install python3 python3-pip # Python 3
### Install Java
# apt -y install default-jdk
# *
### Install Rust
# curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -y
# *
# - - - - - - - - - -

# - - - - - - - - - -
### *** Tools Config ***
echo "[*] Tool Configuration Setup"
### Remove comment on commands to enable Tool installation 
# *
### Install Nmap tool in the Box (Network Scanning)
apt -y install nmap
# *
### Install Scapy tool in the Box (Network Scanning) {Requires Python}
# pip install --pre scapy[basic]
# *
### Install Netcat tool in the Box (Network Scanning)
# apt -y install netcat-traditional
# *
### Install MOSINT in the Box (Intel Gathering) {Requires Python3}
# apt install python3-pypdf2
# pip3 install tabula
# git clone https://github.com/alpkeskin/mosint.git
# cd mosint/
# pip3 install -r requirements.txt
# *
### Install Ettercap in the Box (Man-in-the-Middle)
# apt -y install ettercap-common
# *
### Install Bettercap in the Box (Man-in-the-Middle)
# apt -y install bettercap
# *
### Install Medusa tool in the Box (Brute Force)
# apt -y install medusa
# *
### Install Hashcat tool in the Box (Password Cracking)
# apt -y install hashcat
# *
### Install John the Riper in the Box (Password Cracking)
#apt -y install john
# *
### Install sqlmap in the Box (SQL Injection)
# apt -y install sqlmap
# *
# - - - - - - - - - -

# - - - - - - - - - -
## *** Keep Alive Config ***
END_TIME=$(date +%s)
echo ' 
 ___  __    ________  ___       ___  ________  ________     ___    ___ ___    
|\  \|\  \ |\   __  \|\  \     |\  \|\   __  \|\   __  \   |\  \  /  /|\  \   
\ \  \/  /|\ \  \|\  \ \  \    \ \  \ \  \|\ /\ \  \|\  \  \ \  \/  / | \  \  
 \ \   ___  \ \   __  \ \  \    \ \  \ \   __  \ \  \\\  \  \ \    / / \ \  \ 
  \ \  \\ \  \ \  \ \  \ \  \____\ \  \ \  \|\  \ \  \\\  \  /     \/   \/  /|
   \ \__\\ \__\ \__\ \__\ \_______\ \__\ \_______\ \_______\/  /\   \   /  // 
    \|__| \|__|\|__|\|__|\|_______|\|__|\|_______|\|_______/__/ /\ __\ /_ //  
                                 Follow the white rabbit   |__|/ \|__||__|/   
                                                                          ' > /etc/motd
echo "Initialized in $(($END_TIME - $START_TIME)) seconds"
echo 'KaliBox ready, have fun hacking :)'
## Keep Kalibox running after init.sh
tail -f /dev/null
# - - - - - - - - - -

