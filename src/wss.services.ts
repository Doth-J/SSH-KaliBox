interface ProxyToSocket{
    destroyed: () => void; 
    tunnel: (data:string) => void;
    error: (err:string) => void;
}

interface SocketToProxy{
    init: (conf:sshConfig) => void;
    command: (data:Buffer) => void;
}

type sshConfig = {
    username: string,
    password: string,
    host: string,
    port: number
}

export {ProxyToSocket,SocketToProxy, sshConfig};

