#Docker-Desktop Windows version 25.0.3 - Default configuration
# $powershell.exe -File docker_build.ps1

docker build -t kind_docker_image .
docker run -d --network=host -v /var/run/docker.sock:/var/run/docker.sock --name kind_container kind_docker_image
docker ps -a
docker exec -it kind_container /bin/bash
