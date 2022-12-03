#!/bin/bash
NAMESPACE=$1
# kubectl create namespace $NAMESPACE
kubectl create clusterrolebinding $NAMESPACE:knative-serving-namespaced-admin \
--clusterrole=knative-serving-namespaced-admin  --serviceaccount=$NAMESPACE:default
