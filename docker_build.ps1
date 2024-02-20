# Docker-Desktop Windows version 25.0.3 - Default configuration | $powershell.exe -File docker_build.ps1

# Build Docker image
docker build -t kind_docker_image .
# Run Docker container
docker run -d --network=host -v /var/run/docker.sock:/var/run/docker.sock --name kind_container kind_docker_image
# Display container information
docker ps -a
# Execute Ansible playbook inside the Docker container
docker exec -it kind_container /bin/bash -c "ansible-playbook playbook.yaml"