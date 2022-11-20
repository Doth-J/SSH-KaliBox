import { NodeSSH } from "node-ssh";

const ssh = new NodeSSH()

// TERMINAL CONFIGURATION HERE
let sshConfig = {
    host: 'localhost',
    port: 4000,
    username: 'player',
    password: 'kali'
}

const connect = async () => {
    
    console.log("[>]","Connecting to",sshConfig.host+":"+sshConfig.port);
    await ssh.connect(sshConfig);
    const shellStream = await ssh.requestShell();

    const stdin = process.openStdin();
    stdin.addListener("data",(data:Buffer) => {
      shellStream.write(data.toString());
    });
    shellStream.on("data", (data:Buffer) => {
        process.stdout.write(data.toString());
    });
    shellStream.stderr.on("data", (data:Buffer) => {
      process.stdout.write(data.toString());
    });
    shellStream.on('close',()=>{
      process.exit();
    })
}

connect()
.catch((err)=>{
    console.log("[#]","Error",err);
})