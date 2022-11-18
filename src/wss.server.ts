import { Server } from "socket.io";
import { NodeSSH } from "node-ssh";
import { SocketToProxy,ProxyToSocket, sshConfig } from "./wss.services";

const io = new Server<SocketToProxy,ProxyToSocket>();
const ssh = new NodeSSH();

io.on('connection',(socket)=>{

    console.log("[+] Connected:",socket.id);

    socket.on('disconnect',()=>{
        console.log("[-] Disconnected:",socket.id);
    })
    
    socket.on('init',async(conf)=>{
    
        const config:sshConfig = {
            host: conf.host,
            username: conf.username,
            password: conf.password,
            port: conf.port
        }
        console.log("[*]","Trying to connect to", config.host+":"+config.port);
        
        try{
            await ssh.connect(config);
            const shellStream = await ssh.requestShell();
            console.log("[!]","Socket connect to", config.host+":"+config.port);
            socket.on('command',(data:Buffer)=>{
                shellStream.write(data.toString());
            })
            socket.on('disconnect',()=>{
                shellStream.write("exit");
            })
            shellStream.on("data",(data:Buffer)=>{
                socket.emit("tunnel",data.toString());
            })
            shellStream.stderr.on('data',(err:Buffer)=>{
                socket.emit("error",err.toString());
            })
        }catch(err:any){
            socket.emit("error",err.toString());
        }
        
    }) 
})

const port = process.env.PORT ? parseInt(process.env.PORT) : 3000
io.listen(port)
console.log("[@] Server started at",port);