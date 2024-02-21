#$powershell.exe -File docker_remove.ps1

docker stop kind_container
docker rm kind_container
docker image prune --all --force
docker system prune -f