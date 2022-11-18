import {spawn} from "child_process";

function buildKaliBox(){
    const docker = spawn('docker',['build','-t','kalibox','./kalibox'])

    docker.stdout.on('data', (data) => {
        console.log(`stdout: ${data}`);
    });

    docker.stderr.on("data", (data) => {
        console.log(`stderr: ${data}`);
    });

    docker.on('close', (code) => {
    console.log(`child process exited with code ${code}`);
    });
}
function createKaliBox(hostPort: number, rootPass: string, userPass:string){

    const docker = spawn('docker',['run','-d','-p',hostPort+':22','kalibox', rootPass, userPass]);

    docker.stdout.on('data', (data) => {
    console.log(`stdout: ${data}`);
    });
    docker.stderr.on("data", (data) => {
        console.log(`stderr: ${data}`);
    });
    docker.on('close', (code) => {
    console.log(`child process exited with code ${code}`);
    });
}

switch(process.argv[2]){
    case "build":{
        buildKaliBox();
        break;
    }
    case "run":{
        createKaliBox(parseInt(process.argv[3]),process.argv[4],process.argv[5]);
    }
}