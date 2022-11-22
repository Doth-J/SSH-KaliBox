# **SSH - KaliBox** :toolbox: 
This project builds a minimal Kali Linux Docker Image with basic networking tools and SSH support. The KaliBox base image can then be expanded by configuring various tools and plugins in the *init.sh* script.

## Configure the Image :gear:
Before building the KaliBox image, the configuration can be done by changing the comments inside the [init.sh](./kalibox/init.sh) script in the kalibox directory:
- `Access Config`: Configure passwords and create new players.
- `SSH Config`: Configure SSH to backup default keys, generate new keys and start the ssh service.
- `Language Config`: Configure Language support for the image.
- `Tools Config`: Configure and extend Kali Linux Tools.

## Build and Run the Image using NodeJs :zap:
If you are going to use NodeJs to build and run the KaliBox image, be sure to install the project's dependencies after cloning the repository:
```console
npm install 
```
Execute the following script inside the project directory to build the image:
```console
npm run kb:build
``` 
Once you build the image you can run it with the following script:
```console
npm run kp:run <HOST-PORT> <ROOT-PASSWORD> <PLAYER-PASSWORD>
```
- `<HOST-PORT>`: [**number**] Define the host port for the Image to bind SSH service. 
- `<ROOT-PASSWORD>`: [**string**] Define the root password for the Image. 
- `<PLAYER-PASSWORD>`: [**string**] Define the player password for the Image. 
## Build and Run the Image using Docker :whale:
After cloning the repository, execute the following command inside the project directory to build the image:
```console
docker build -t kalibox ./kalibox
```
Once you build the image you can run it using:
```console
docker run -d -p <HOST-PORT>:22 kalibox <ROOT-PASSWORD> <PLAYER-PASSWORD> 
```
- `<HOST-PORT>`: [**number**] Define the host port for the Image to bind SSH service. 
- `<ROOT-PASSWORD>`: [**string**] Define the root password for the Image. 
- `<PLAYER-PASSWORD>`: [**string**] Define the player password for the Image. 
  
## Building the KaliBox Network :package:
You can use *docker compose* to build a network stack with KaliBox and a WSS Proxy in the same network and interact with them through the terminal and WS client scripts respectively. Execute the following command inside the project directory to start the network:
```console
docker compose up
```  
## Connecting to KaliBox :dragon:
To connect to your fresh KaliBox container you can use one of the following methods:

1. `Command Prompt`: Open a command prompt and enter the following command:
   ```console
    ssh -p <HOST-PORT> player@localhost 
    Password: <PLAYER-PASSWORD>
   ```
   :warning: If there is an entry for `[localhost]:<HOST-PORT>`  inside */.ssh/known_hosts* go ahead and delete it, if you don't you will get a warning that the remote host identification has changed and you won't be allowed to connect. This happens because everytime the container restarts, unless reconfigured, it generates new SSH key pairs.

2. `NodeJs Terminal`: Inside the [terminal](src/ssh.terminal.ts) specify the correct **host**, **port** and **credentials** in the ***config*** object.You can then execute the following command inside the project directory to open a virtual ssh terminal into KaliBox:
   ```console  
   npm run tty
   ```   
3. `Socket.io Server`: For the WSS Proxy server you can specify the **port** of the server inside the [server](src/wss.server.ts) file (default: **3000**), then inside the project directory execute the following script:
   ```console   
   npm run dev
   ```
   You can build and run the WSS Proxy with the following command:
   ```console
   npm run start
   ```
   After ther server has started you can the use the WS client inside the [client](src/ws.client.ts) file to get an interactive shell, by executing the following script:
   ```console
   npm run client
   ```

## KaliBox Configuration :wrench:
Once you are connected to KaliBox be sure to change the initial configurations of *init.sh* in the container's **/box** directory. Here's an example how to change the root password, persist it through container restarts and disable ssh key generation:
```console
player@<CONTAINER-ID>:~$ su root
Password:<ROOT-PASSWORD>
root@<CONTAINER-ID>:~$[/home/player] echo "root:<NEW-PASSWORD>" | chpasswd
root@<CONTAINER-ID>:~$[/home/player] cd /box 
root@<CONTAINER-ID>:~$[/box] nano init.sh 
```
```bash
#!/bin/bash
apt-get update

# - - - - - - - - - -
### *** Access Config ***
echo "[*] Access Configuration Setup"
### Remove comment on commands to enable Access configurations 
### Change root password
# echo "root:$1" | chpasswd <-- COMMENT OUT THIS TO PERSIST LATEST ROOT PASS
.
.
### Generate new SSH keys
# dpkg-reconfigure openssh-server <-- COMMENT OUT THIS TO DISABLE SSH KEYGEN
.
.
```
