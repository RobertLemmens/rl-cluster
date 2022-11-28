#!/bin/bash
# first insert secrets

kubectl create namespace argocd
kubectl create namespace rl-cluster
kubectl create namespace ingress-nginx
kubectl create namespace tekton-pipelines
#kubectl create namespace loki
#kubectl create namespace minio
kubectl create namespace tools
kubectl create namespace jaeger

git clone https://github.com/argoproj/argo-helm.git 
helm dependency update argo-helm/charts/argo-cd
helm install argo-cd argo-helm/charts/argo-cd -n argocd
kubectl rollout status deployment argo-cd-argocd-server -n argocd
rm -rf argo-helm

kubectl apply -f project.yaml
kubectl apply -f cluster-root.yaml

# wait for nginx
# sleep 30
# echo '
#   apiVersion: v1
#   kind: ConfigMap
#   data:
#     enable-opentracing: "true"
#     jaeger-collector-host: simplest-agent.jaeger.svc.cluster.local              
#   metadata:
#     name: ingress-nginx-controller
#     namespace: ingress-nginx
#   ' | kubectl replace -f -
