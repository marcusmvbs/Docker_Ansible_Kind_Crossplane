# Common Variables
$imageName     = "kind_docker_image"
$containerName = "kind_container"
$network_type  = "--network=host"
$socket_volume = "/var/run/docker.sock:/var/run/docker.sock"
$playbook_exec =  "ansible-playbook -i ../ansible/inventory.ini ../ansible/playbook.yaml"

# Docker Variables
$DockerBuildCmd = "docker build -t $imageName ."
$DockerRunCmd   = "docker run -d $network_type -v $socket_volume --name $containerName $imageName"

# Ansible Variables
$AnsiblePlaybook = "docker exec -it $containerName sh -c '$playbook_exec'"

## RUN commands ##
# Build Docker container
Invoke-Expression -Command $DockerBuildCmd
# Run Docker container
Invoke-Expression -Command $DockerRunCmd
# Execute Ansible tasks
Invoke-Expression -Command $AnsiblePlaybook