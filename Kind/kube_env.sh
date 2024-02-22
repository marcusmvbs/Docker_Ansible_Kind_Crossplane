#!/bin/bash

## $../kube_script/kube_env.sh ##

## Basic commands ##
kubectl get svc
echo "" # For better visualization on terminal
kubectl get nodes
echo ""

## Labeling worker nodes ##
kubectl label node kind-worker node-role.kubernetes.io/worker=worker
kubectl label node kind-worker2 node-role.kubernetes.io/worker=worker
echo ""

kubectl get nodes -o wide
# kubectl describe node kind-worker2 | more
# kubectl describe node kind-worker2 | more
echo ""

## Control plane ##
# kubectl get pods --all-namespaces -o wide | grep -i apiserver

## Control plane & worker nodes ##
# kubectl get pods --all-namespaces -o wide | grep -i kube-proxy

## External access ##
ls -l ~/.kube/config
# $exit
# $scp -i C:/Users/marcu/.ssh/authorized_keys root@localhost:/root/.kube/config
