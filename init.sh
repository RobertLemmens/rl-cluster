#!/bin/bash
# first insert secrets

kubectl create namespace argocd
kubectl create namespace rl-cluster
kubectl create namespace ingress-nginx
kubectl create namespace tekton-pipelines
kubectl create namespace knative

# git clone https://github.com/argoproj/argo-helm.git 
# helm dependency update argo-helm/charts/argo-cd
# helm install argo-cd argo-helm/charts/argo-cd -n argocd
# kubectl rollout status deployment argo-cd-argocd-server -n argocd
# rm -rf argo-helm


# Download the latest tekton (at time of writing, they did not supply help repo's or install yamls in their git repo, only release page)
# these are safe to commit - so we update then every time we run this script basically
curl https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml -o cluster-applications/tekton/pipelines.yaml
curl https://storage.googleapis.com/tekton-releases/triggers/latest/release.yaml -o cluster-applications/tekton/triggers.yaml
curl https://storage.googleapis.com/tekton-releases/triggers/latest/interceptors.yaml -o cluster-applications/tekton/interceptors.yaml
curl https://storage.googleapis.com/tekton-releases/dashboard/latest/tekton-dashboard-release.yaml -o cluster-applications/tekton/dashboard.yaml

# Same for knative 
curl https://github.com/knative/operator/releases/download/knative-v1.8.1/operator.yaml -o cluster-applications/knative/operator.yaml

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
