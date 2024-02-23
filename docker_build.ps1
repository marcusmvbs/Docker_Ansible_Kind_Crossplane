# Docker-Desktop Windows version 25.0.3 - Default configuration | $powershell.exe -File docker_build.ps1
# Common Variables
$imageName     = "kind_docker_image"
$containerName = "kind_container"
$network_type  = "--network=host"
$socket_volume = "/var/run/docker.sock:/var/run/docker.sock"
$playbook_exec =  "ansible-playbook -i ../ansible/inventory.ini ../ansible/playbook.yaml"

# Docker Variables
$dockerBuildCommand  = "docker build -t $imageName ."
$dockerRunCommand    = "docker run -d $network_type -v $socket_volume --name $containerName $imageName"
$dockerContainerInfo = "docker ps -a"

# Ansible Variables
$ansibleplaybook = "docker exec -it $containerName sh -c '$playbook_exec'"

## RUN commands ##

# Rebuild the Docker container
Invoke-Expression -Command $dockerBuildCommand

# Run Docker container
Invoke-Expression -Command $dockerRunCommand

# Run Docker container
Invoke-Expression -Command $dockerContainerInfo

# Execute Ansible tasks
Invoke-Expression -Command $ansibleplaybook