#!/bin/bash
kubectl -n rl-cluster get secret prometheus-grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
