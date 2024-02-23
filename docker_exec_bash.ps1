# Common Variables
$containerName = "kind_container"
$playbook_exec =  "ansible-playbook -i ../ansible/inventory.ini ../ansible/playbook.yaml"

# Versions
$python3_version = "python3 --version"
$ansible_version = "ansible --version"
$docker_version = "docker --version"
$kind_version = "kind version"
$helm_version = "helm version --short"
$kubectl_version = "kubectl version --client --short"

# Docker Exec bash
$dockerExecCommand   = "docker exec -it $containerName /bin/bash"

## RUN commands ##

# Execute Docker container to delete kind cluster
Invoke-Expression -Command $dockerExecCommand

# Versions
Invoke-Expression -Command $python3_version
Invoke-Expression -Command $ansible_version
Invoke-Expression -Command $docker_version
Invoke-Expression -Command $kind_version
Invoke-Expression -Command $helm_version
Invoke-Expression -Command $kubectl_version

# Execute Ansible tasks
Invoke-Expression -Command $playbook_exec