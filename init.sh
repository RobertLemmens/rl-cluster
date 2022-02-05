#!/bin/bash
# first insert secrets

kubectl create namespace argocd
kubectl create namespace rl-cluster
kubectl create namespace ingress-nginx
kubectl create namespace tekton-pipelines
kubectl create namespace loki
kubectl create namespace minio

helm dependency update ./cluster-applications/argocd/charts/argo-cd
helm install argo-cd ./cluster-applications/argocd/charts/argo-cd -n argocd
kubectl rollout status deployment argo-cd-argocd-server -n argocd

kubectl apply -f project.yaml
kubectl apply -f cluster-root.yaml

# wait for nginx
echo '
  apiVersion: v1
  kind: ConfigMap
  data:
    enable-opentracing: "true"
    jaeger-collector-host: simplest-agent.jaeger.svc.cluster.local              
  metadata:
    name: ingress-nginx-controller
    namespace: ingress-nginx
  ' | kubectl replace -f -
