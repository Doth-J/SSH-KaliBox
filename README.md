# **SSH KaliBox** :toolbox:
This project builds a minimal Kali Linux Docker Image with basic networkings tools and SSH support. The KaliBox base image can then be expanded by configuring various tools and plugins in the *init.sh* script.

## Configure the Image :gear:
Before building the KaliBox image, the configuration can be done by changing the comments inside the [init.sh](./kalibox/init.sh) script in the kalibox directory:
- `Access Config`: Configure passwords and create new players.
- `SSH Config`: Configure SSH to backup default keys, generate new keys and start the ssh service.
- `Language Config`: Configure Language support for the image.
- `Tools Config`: Configure and extend Kali Linux Tools.

## Build the Image using NodeJs :zap:
After cloning the repository, install the project dependencies and execute the following script inside the project directory to build the image:
```
npm install
npm run kb:build
``` 
## Run the Image using NodeJs :zap:
Once you build the image you can run it with the following script:
```
npm run kp:run <HOST-PORT> <ROOT-PASSWORD> <PLAYER-PASSWORD>
```
- `<HOST-PORT>`: [**number**] Define the host port for the Image to bind SSH service. 
- `<ROOT-PASSWORD>`: [**string**] Define the root password for the Image. 
- `<PLAYER-PASSWORD>`: [**string**] Define the player password for the Image. 
## Build the Image using Docker :whale:
After cloning the repository, execute the following command inside the project directory to build the image:
```
docker build -t kalibox ./kalibox
```
## Run the Image using Docker :whale:
Once you build the image you can run it using:
```
docker run -d -p <HOST-PORT>:22 kalibox <ROOT-PASSWORD> <PLAYER-PASSWORD> 
```
- `<HOST-PORT>`: [**number**] Define the host port for the Image to bind SSH service. 
- `<ROOT-PASSWORD>`: [**string**] Define the root password for the Image. 
- `<PLAYER-PASSWORD>`: [**string**] Define the player password for the Image. 
  
## Connecting to KaliBox :dragon:
To connect to your fresh KaliBox container you can use one of the following methods:

1. `Command Prompt`: Locate the known_hosts file inside */.ssh* directory (usually located inside the user's directory). If there is an entry for `[localhost]:<HOST-PORT>` delete it, if you don't you will get a warning that the remote host identification has changed and won't be allowed to connect. This happens because everytime the container restarts, it generates new SSH key pairs. Once you delete the entry, open a command prompt and enter the following command:
   
   ```
    > ssh -p <HOST-PORT> player@localhost 
    > player@localhost's password: <PLAYER-PASSWORD>
   ```
2. `NodeJs Terminal`: Inside the [terminal](src/ssh.terminal.ts) specify the correct **host**, **port** and **credentials** in the ***config*** object.You can then execute the following command inside the project directory to open a virtual ssh terminal into KaliBox:
   ```   
   > npm run tty
   ```   
3. `Socket.io Server`: For the WSS Proxy server you can specify the **port** of the server inside the [server](src/wss.server.ts) file (default: **3000**), then inside the project directory execute the following script:
   ```   
   > npm run dev <-- Requires dev dependencies installed
   or
   > npm run start
   ```
   After ther server has started you can the use the WS client inside the [client](src/ws.client.ts) file to get an interactive shell, by executing the following script:
   ```
   > npm run client
   ```

## Container Configuration :shield:
Once you are connected to KaliBox be sure to escalate to root and change the configurations of *init.sh* in the container's **/box** directory. Here's an example how to change the root password and persist it through container restarts:
```
> player@<CONTAINER-ID>:~$ su root
> Password:<ROOT-PASSWORD>
> root@<CONTAINER-ID>:~$[/home/player] echo "root:<NEW-PASSWORD>" | chpasswd
> root@<CONTAINER-ID>:~$[/home/player] cd /box 
> root@<CONTAINER-ID>:~$[/box] nano init.sh 

#!/bin/bash
apt-get update

# - - - - - - - - - -
### *** Access Config ***
## Remove comment on commands to enable Access configurations 
## Change root password
# echo "root:$1" | chpasswd <-- COMMENT OUT THIS TO PERSIST LATEST ROOT PASS
...
```
