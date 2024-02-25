# Common Variables
$containerName = "kind_container"

# Versions
$python3_version    = "python3 --version"
$ansible_version    = "ansible --version"
$docker_version     = "docker --version"
$kind_version       = "kind version"
$helm_version       = "helm version --short"
$kubectl_version    = "kubectl version --client --short"
$kubectl_pods       = "kubectl get pods -A"
$kubectl_crossplane = "kubectl get crossplane"
$kubectl_bucket     = "kubectl get bucket"

# Docker exec bash
$PythonVersion        = "docker exec -it $containerName sh -c '$python3_version'"
$AnsibleVersion       = "docker exec -it $containerName sh -c '$ansible_version'"
$DockerVersion        = "docker exec -it $containerName sh -c '$docker_version'"
$KindVersion          = "docker exec -it $containerName sh -c '$kind_version'"
$HelmVersion          = "docker exec -it $containerName sh -c '$helm_version'"
$KubectlVersion       = "docker exec -it $containerName sh -c '$kubectl_version'"
$KubectlGetPods       = "docker exec -it $containerName sh -c '$kubectl_pods'"
$KubectlGetCrossplane = "docker exec -it $containerName sh -c '$kubectl_crossplane'"
$KubectlGetBucket     = "docker exec -it $containerName sh -c '$kubectl_bucket'"
$DockerExecCommand    = "docker exec -it $containerName /bin/bash"

## RUN commands ##
# Invoke-Expression -Command $PythonVersion
# Invoke-Expression -Command $AnsibleVersion
# Invoke-Expression -Command $DockerVersion
# Invoke-Expression -Command $KindVersion
# Invoke-Expression -Command $HelmVersion
# Invoke-Expression -Command $KubectlVersion
Invoke-Expression -Command $KubectlGetPods
# Invoke-Expression -Command $KubectlGetCrossplane
Invoke-Expression -Command $KubectlGetBucket

# Execute Docker container
Invoke-Expression -Command $DockerExecCommand