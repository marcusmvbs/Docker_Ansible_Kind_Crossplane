#!/bin/bash

## $./kube_env.sh ##

## Basic commands ##
# kubectl get svc
# Check if cluster is fully configured via ansible
ansible-playbook -i ../ansible/inventory.ini ../ansible/playbook.yaml
echo "" # For better visualization on terminal


## Labeling worker nodes ##
kubectl label node kind-worker node-role.kubernetes.io/worker=worker
#kubectl label node kind-worker2 node-role.kubernetes.io/worker=worker
kubectl get nodes -o wide
echo ""

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
# echo "nginxingress-ns database-ns monitoring-ns argocd-ns cache-ns kafka-ns" | xargs -n1 kubectl create namespace
# for ns in webserver-ns nginxingress-ns database-ns monitoring-ns argocd-ns cache-ns kafka-ns; do
#     kubectl create namespace $ns
# done
kubectl create namespace argocd-ns
kubectl get ns
echo ""

## Argocd Install and Apply Manifest File ##
kubectl apply -n argocd-ns -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl apply -f ../kind-config/application.yaml
echo ""

## Pods ##
# kubectl get pods -n nginxingress-ns
kubectl get pods -A
# kubectl logs pod-name
# kubectl delete pod pod-name