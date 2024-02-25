# Common Variables
$imageName             = "kind_docker_image"
$containerName         = "kind_container"
$network_type          = "--network=host"
$socket_volume         = "/var/run/docker.sock:/var/run/docker.sock"
$playbook_exec         = "ansible-playbook -i ../ansible/inventory.ini ../ansible/playbook.yaml"
$provider_exec         = "kubectl apply -f ./charts/dev/aws/provider.yaml"
$create_secret         = "kubectl create secret generic aws-creds -n crossplane-ns --from-file=creds=./charts/dev/aws/creds.txt"
$create_providerConfig = "kubectl create -f ./charts/dev/aws/providerconfig.yaml"
$remove_credentials    = "rm ./charts/dev/aws/creds.txt"
$create_bucket         = "kubectl apply -f ./charts/dev/aws/s3.yaml"

# Docker Variables
$DockerBuildCmd = "docker build -t $imageName ."
$DockerRunCmd   = "docker run -d $network_type -v $socket_volume --name $containerName $imageName"

# Ansible Variables
$AnsiblePlaybook = "docker exec -it $containerName sh -c '$playbook_exec'"

# Kubernetes Environment Variables
$Crossplane_AWSProvider = "docker exec -it $containerName sh -c '$provider_exec'"
$Secret_AwsCreds        = "docker exec -it $containerName sh -c '$create_secret'"
$ProviderConfig         = "docker exec -it $containerName sh -c '$create_providerConfig'"
$RemoveCreds            = "docker exec -it $containerName sh -c '$remove_credentials'"
$CreateS3Bucket         = "docker exec -it $containerName sh -c '$create_bucket'"

## RUN commands ##

# Build Docker container
Invoke-Expression -Command $DockerBuildCmd
# Run Docker container
Invoke-Expression -Command $DockerRunCmd

# Execute Ansible tasks
Invoke-Expression -Command $AnsiblePlaybook
Start-Sleep -Seconds 100

# AWS Provider creation
Invoke-Expression -Command $Crossplane_AWSProvider
Start-Sleep -Seconds 170

# Secret and Provider Config
Invoke-Expression -Command $Secret_AwsCreds
Invoke-Expression -Command $ProviderConfig
Invoke-Expression -Command $RemoveCreds
# Provider Resource - S3 Bucket
Invoke-Expression -Command $CreateS3Bucket