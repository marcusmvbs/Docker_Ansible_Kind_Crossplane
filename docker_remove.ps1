# Common Variables
$containerName = "kind_container"

# Docker Variables
$dockerExecDelCommand   = "docker exec -it $containerName sh -c 'kind delete cluster'"
$dockerStopCommand   = "docker stop $containerName"
$dockerRemoveCommand = "docker rm $containerName"
$dockerImagePrune    = "docker image prune --all --force"
$dockerSystemPrune    = "docker system prune -f"

## RUN commands ##

# Execute Docker container to delete kind cluster
Invoke-Expression -Command $dockerExecDelCommand

# Stop the Docker container
Invoke-Expression -Command $dockerStopCommand

# Remove the Docker container
Invoke-Expression -Command $dockerRemoveCommand

# Rebuild the Docker container
Invoke-Expression -Command $dockerImagePrune

# Rebuild the Docker container
Invoke-Expression -Command $dockerSystemPrune