# Common Variables
$imageName     = "kind_docker_image"
$containerName = "kind_container"
$network_type  = "--network=host"
$socket_volume = "/var/run/docker.sock:/var/run/docker.sock"
$playbook_exec =  "ansible-playbook -i ../ansible/inventory.ini ../ansible/playbook.yaml"

# Docker Variables
$dockerBuildCommand  = "docker build -t $imageName ."
$dockerExecDelCommand   = "docker exec -it $containerName sh -c 'kind delete cluster'"
$dockerRunCommand    = "docker run -d $network_type -v $socket_volume --name $containerName $imageName"
$dockerStopCommand   = "docker stop $containerName"
$dockerRemoveCommand = "docker rm $containerName"

# Ansible Variables
$ansibleplaybook = "docker exec -it $containerName sh -c '$playbook_exec'"

## RUN commands ##

# Execute Docker container to delete kind cluster
Invoke-Expression -Command $dockerExecDelCommand

# Stop the Docker container
Invoke-Expression -Command $dockerStopCommand

# Remove the Docker container
Invoke-Expression -Command $dockerRemoveCommand

# Rebuild the Docker container
Invoke-Expression -Command $dockerBuildCommand

# Run Docker container
Invoke-Expression -Command $dockerRunCommand

# Execute Ansible tasks
Invoke-Expression -Command $ansibleplaybook