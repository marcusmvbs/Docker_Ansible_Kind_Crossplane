#!/bin/bash

# Initialize Kind cluster
kind create cluster --config /kind-config/kind-config.yaml
#kubectl apply -f kind-config/nginx-service.yaml

# Keep the container running
tail -f /dev/null