#!/bin/bash

# Initialize Kind cluster
kind create cluster --config /kind-config/kind-config.yaml
kind get clusters
#kubectl apply -f kind-config/nginx-service.yaml
kubectl get services

# Keep the container running
tail -f /dev/null