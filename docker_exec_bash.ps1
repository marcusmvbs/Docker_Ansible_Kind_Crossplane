# Common Variables
$containerName = "kind_container"

# Versions
$python3_version = "python3 --version"
$ansible_version = "ansible --version"
$docker_version  = "docker --version"
$kind_version    = "kind version"
$helm_version    = "helm version --short"
$kubectl_version = "kubectl version --client --short"
$kubectl_pods    = "kubectl get pods -A"

# Docker Exec bash
$PythonVersion     = "docker exec -it $containerName sh -c '$python3_version'"
$AnsibleVersion    = "docker exec -it $containerName sh -c '$ansible_version'"
$DockerVersion     = "docker exec -it $containerName sh -c '$docker_version'"
$KindVersion       = "docker exec -it $containerName sh -c '$kind_version'"
$HelmVersion       = "docker exec -it $containerName sh -c '$helm_version'"
$KubectlVersion    = "docker exec -it $containerName sh -c '$kubectl_version'"
$KubectlPods       = "docker exec -it $containerName sh -c '$kubectl_pods'"
$dockerExecCommand = "docker exec -it $containerName /bin/bash"

## RUN commands ##

# Versions
Invoke-Expression -Command $PythonVersion
Invoke-Expression -Command $AnsibleVersion
Invoke-Expression -Command $DockerVersion
Invoke-Expression -Command $KindVersion
Invoke-Expression -Command $HelmVersion
Invoke-Expression -Command $KubectlVersion
Invoke-Expression -Command $KubectlPods

# Execute Docker container
Invoke-Expression -Command $dockerExecCommand