import { NodeSSH } from "node-ssh";

const ssh = new NodeSSH()

// TERMINAL CONFIGURATION HERE
let sshConfig = {
    host: '127.0.0.1',
    username: 'player',
    password: 'kali',
    port: 4000
}

const connect = async () => {
    
    console.log("Connecting to",sshConfig.host+":"+sshConfig.port);
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
}

connect()
.catch((err)=>{
    console.log("# Error",err);
})