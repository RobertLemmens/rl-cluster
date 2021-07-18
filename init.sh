#!/bin/bash
kubectl create namespace argocd
kubectl create namespace rl-cluster
kubectl create namespace ingress-nginx

kubectl apply -f project.yaml
kubectl apply -f cluster-root.yaml
