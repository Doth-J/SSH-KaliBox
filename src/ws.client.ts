import { SocketToProxy,ProxyToSocket, sshConfig } from "./wss.services";
import {io, Socket} from "socket.io-client";

const proxyPath = "http://localhost:3000";
const socket: Socket<ProxyToSocket,SocketToProxy> = io(proxyPath, {reconnectionDelay:5000});

const config:sshConfig = {
    username:"player",
    password:"kali",
    host:"127.0.0.1",
    port: 4000
}

socket.on('connect',()=>{

    socket.emit('init',config);
    const stdin = process.openStdin();
    stdin.addListener("data",(data:Buffer)=>{
        socket.emit('command',data);
    })
})

socket.on('disconnect',()=>{
    console.log("[*]","Trying to disconnect...")
})

socket.on('tunnel',(data)=>{
    process.stdout.write(data);
})

socket.on('error',(data)=>{
    process.stdout.write(data);
})