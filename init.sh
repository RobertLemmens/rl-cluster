#!/bin/bash
kubectl create namespace argocd
kubectl create namespace rl-cluster
kubectl create namespace ingress-nginx
kubectl create namespace tekton-pipelines

kubectl apply -f project.yaml
kubectl apply -f cluster-root.yaml
