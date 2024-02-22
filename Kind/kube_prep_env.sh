#!/bin/bash

## $../kube_script/kube_env.sh ##

## Basic commands ##
kubectl get svc
echo "" # For better visualization on terminal

## Labeling worker nodes ##
kubectl label node kind-worker node-role.kubernetes.io/worker=worker
kubectl label node kind-worker2 node-role.kubernetes.io/worker=worker
echo ""

kubectl get nodes -o wide
# kubectl describe node kind-worker | more
# kubectl describe node kind-worker2 | more
echo ""

## Control plane ##
# kubectl get pods --all-namespaces -o wide | grep -i apiserver

## Control plane & worker nodes ##
# kubectl get pods --all-namespaces -o wide | grep -i kube-proxy

## External access ##
#ls -l ~/.kube/config
# $exit
# $scp -i C:/Users/marcu/.ssh/authorized_keys root@localhost:/root/.kube/config C:/Users/marcu/.kube/config
# $ssh -i C:/Users/marcu/.ssh/authorized_keys root@localhost

## Namespace ##
# $kubectl api-resources --namespaced=true && false 
echo "nginxingress-ns database-ns monitoring-ns argocd-ns cache-ns kafka-ns" | xargs -n1 kubectl create namespace
# for ns in webserver-ns nginxingress-ns database-ns monitoring-ns argocd-ns cache-ns kafka-ns; do
#     kubectl create namespace $ns
# done
echo ""

## Helm packages installation - CURRENT TASK
helm install nginx-ingress ingress-nginx/ingress-nginx --namespace nginxingress-ns
# helm install {{ POSTGRES_RELEASE }} stable/postgresql --namespace database-ns
# helm install {{ FLUENT_BIT_RELEASE }} stable/fluent-bit
# helm install {{ REDIS_RELEASE }} stable/redis
# helm install {{ PROMETHEUS_RELEASE }} stable/prometheus
# helm install my-kasten kasten/k10
echo ""

## Argocd Install and Apply Manifest File ##
kubectl apply -n argocd-ns -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
#kubectl apply -f ../kind-config/application.yaml
echo ""

## Pods ##
# kubectl get pods -n nginxingress-ns
kubectl get pods -A
# kubectl logs pod-name
# kubectl delete pod pod-name