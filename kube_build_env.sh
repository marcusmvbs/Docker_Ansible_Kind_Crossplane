#!/bin/bash

# $../kube_script/kube_build_env.sh
echo "" # For better visualization on terminal

# Basic commands
kubectl get svc
kubectl get nodes
echo ""

# Labeling worker nodes
kubectl label node kind-worker node-role.kubernetes.io/worker=worker
kubectl label node kind-worker2 node-role.kubernetes.io/worker=worker
echo ""

kubectl get nodes -o wide
kubectl describe node kind-worker | more
# kubectl describe node kind-worker2 | more

