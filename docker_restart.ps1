# Common Variables
$imageName             = "kind_docker_image"
$containerName         = "kind_container"
$network_type          = "--network=host"
$socket_volume         = "/var/run/docker.sock:/var/run/docker.sock"
$playbook_exec         =  "ansible-playbook -i ../ansible/inventory.ini ../ansible/playbook.yaml"
$provider_exec         = "kubectl apply -f ./charts/dev/aws/provider.yaml"
$create_secret         = "kubectl create secret generic aws-creds -n crossplane-ns --from-file=creds=./charts/dev/aws/creds.txt"
$create_providerConfig = "kubectl create -f ./charts/dev/aws/providerconfig.yaml"
$remove_credentials    = "rm ./charts/dev/aws/creds.txt"
$create_bucket         = "kubectl apply -f ./charts/dev/aws/s3.yaml"

# Docker Variables
$KubectlDelBucketCmd = "docker exec -it $containerName sh -c 'kubectl delete bucket dak-bucket-vini'"
$KindDelCmd          = "docker exec -it $containerName sh -c 'kind delete cluster'"
$DockerStopCmd       = "docker stop $containerName"
$DockerRemoveCmd     = "docker rm $containerName"
$DockerBuildCmd      = "docker build -t $imageName ."
$DockerRunCmd        = "docker run -d $network_type -v $socket_volume --name $containerName $imageName"

# Ansible Variables
$AnsiblePlaybook = "docker exec -it $containerName sh -c '$playbook_exec'"

# Kubernetes Environment Variables
$Crossplane_AWSProvider = "docker exec -it $containerName sh -c '$provider_exec'"
$Secret_AwsCreds        = "docker exec -it $containerName sh -c '$create_secret'"
$ProviderConfig         = "docker exec -it $containerName sh -c '$create_providerConfig'"
$RemoveCreds            = "docker exec -it $containerName sh -c '$remove_credentials'"
$CreateS3Bucket         = "docker exec -it $containerName sh -c '$create_bucket'"

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

# AWS Provider creation
Invoke-Expression -Command $Crossplane_AWSProvider
# Secret and Provider Config
Invoke-Expression -Command $Secret_AwsCreds
Invoke-Expression -Command $ProviderConfig
Invoke-Expression -Command $RemoveCreds
# Provider Resource - S3 Bucket
Invoke-Expression -Command $CreateS3Bucket