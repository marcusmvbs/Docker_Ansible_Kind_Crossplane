# Common Variables
$imageName     = "kind_docker_image"
$containerName = "kind_container"
$network_type  = "--network=host"
$socket_volume = "/var/run/docker.sock:/var/run/docker.sock"
$playbook_exec =  "ansible-playbook -i ../ansible/inventory.ini ../ansible/playbook.yaml"

# Docker Variables
$KubectlDelBucketCmd = "docker exec -it $containerName sh -c 'kubectl delete bucket dak-bucket'"
$KindDelCmd          = "docker exec -it $containerName sh -c 'kind delete cluster'"
$DockerStopCmd       = "docker stop $containerName"
$DockerRemoveCmd     = "docker rm $containerName"
$DockerBuildCmd      = "docker build -t $imageName ."
$DockerRunCmd        = "docker run -d $network_type -v $socket_volume --name $containerName $imageName"

# Ansible Variables
$AnsiblePlaybook = "docker exec -it $containerName sh -c '$playbook_exec'"

## RUN commands ##
# Execute Kubectl on Docker container to delete AWS S3 Resource
Invoke-Expression -Command $KubectlDelBucketCmd
# Execute Docker container to delete kind cluster
Invoke-Expression -Command $KindDelCmd
# Stop the Docker container
Invoke-Expression -Command $DockerStopCmd
# Remove the Docker container
Invoke-Expression -Command $DockerRemoveCmd

Invoke-Expression -Command $DockerBuildCmd

Invoke-Expression -Command $DockerRunCmd

Invoke-Expression -Command $AnsiblePlaybook