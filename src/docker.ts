import {spawn} from "child_process";

export default function createKaliBox(hostPort: number, rootPass: string, userPass:string){

    const docker = spawn('docker',['run','-d','-p',hostPort+':22','kalibox', rootPass, userPass]);

    docker.stdout.on('data', (data) => {
    console.log(`Response: ${data}`);
    });
    docker.stderr.on("data", (data) => {
        console.log(`Error: ${data}`);
    });
    docker.on('close', (code) => {
    console.log(`Docker process exited with code ${code}`);
    });
}

createKaliBox(parseInt(process.argv[2]),process.argv[3],process.argv[4]);
