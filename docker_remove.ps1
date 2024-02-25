# Common Variables
$containerName = "kind_container"

# Docker Variables
$KubectlDelBucketCmd = "docker exec -it $containerName sh -c 'kubectl delete bucket dak-bucket-vini'"
$KindDelCmd          = "docker exec -it $containerName sh -c 'kind delete cluster'"
$DockerStopCmd       = "docker stop $containerName"
$DockerRemoveCmd     = "docker rm $containerName"
$DockerImagePrune    = "docker image prune --all --force"
$DockerSystemPrune   = "docker system prune -f"

## RUN commands ##
Invoke-Expression -Command $KubectlDelBucketCmd

Invoke-Expression -Command $KindDelCmd

Invoke-Expression -Command $DockerStopCmd

Invoke-Expression -Command $DockerRemoveCmd
# Remove Docker images
Invoke-Expression -Command $DockerImagePrune
# Remove Docker volumes
Invoke-Expression -Command $DockerSystemPrune