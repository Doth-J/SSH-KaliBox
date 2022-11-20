import { SocketToProxy,ProxyToSocket, sshConfig } from "./wss.services";
import {io, Socket} from "socket.io-client";

const proxyPath = "ws://localhost:3000";
const socket: Socket<ProxyToSocket,SocketToProxy> = io(proxyPath, {reconnectionDelay:5000});

const config:sshConfig = {
    host:"KaliBox",
    port: 22,
    username:"player",
    password:"kali"
}

socket.on('connect',()=>{
    console.log("[>]","Connecting to",config.host+":"+config.port);
    socket.emit('init',config);
    const stdin = process.openStdin();
    stdin.addListener("data",(data:Buffer)=>{
        socket.emit('command',data.toString());
    })
})

socket.on('disconnect',()=>{
    console.log("[*]","Trying to reconnect...")
})

socket.on('tunnel',(data)=>{
    process.stdout.write(data);
})

socket.on('error',(data)=>{
    process.stdout.write(data);
})