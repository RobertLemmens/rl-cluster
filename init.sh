#!/bin/bash
kubectl create namespace argocd
kubectl create namespace rl-cluster
kubectl create namespace ingress-nginx
kubectl create namespace tekton-pipelines
kubectl create namespace loki
kubectl create namespace minio

kubectl apply -f project.yaml
kubectl apply -f cluster-root.yaml
