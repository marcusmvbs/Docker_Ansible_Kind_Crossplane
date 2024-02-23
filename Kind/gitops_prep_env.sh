#!/bin/bash

## Basic commands ##
# kubectl get svc

# # Check if cluster is fully configured via ansible
# ansible-playbook -i ../ansible/inventory.ini ../ansible/playbook.yaml


## Labeling worker nodes ##
kubectl label node kind-worker node-role.kubernetes.io/worker=worker
kubectl label node kind-worker2 node-role.kubernetes.io/worker=worker
#kubectl get nodes -o wide

# kubectl describe node kind-worker | more
# kubectl describe node kind-worker2 | more 
# echo ""

## Control plane ##
# kubectl get pods --all-namespaces -o wide | grep -i apiserver
## Control plane & worker nodes ##
# kubectl get pods --all-namespaces -o wide | grep -i kube-proxy

## External access ##
# ls -l ~/.kube/config
# $exit
# $scp -i C:/Users/marcu/.ssh/authorized_keys root@localhost:/root/.kube/config C:/Users/marcu/.kube/config
# $ssh -i C:/Users/marcu/.ssh/authorized_keys root@localhost

## Namespace ##
# kubectl api-resources --namespaced=true && false 
kubectl create namespace argocd-ns
# kubectl get ns

## Argocd Install and Apply Manifest File ##
kubectl apply -n argocd-ns -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl apply -f ../kind-config/application.yaml

## Pods ##
# kubectl get pods -n nginxingress-ns
# kubectl get pods -A
# kubectl logs pod-name
# kubectl delete pod pod-name