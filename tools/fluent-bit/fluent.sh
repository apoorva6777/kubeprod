#!/bin/bash

echo "Starting fluentbit deployments"

echo "Adding Helm repo for fluentbit"

helm repo add fluent https://fluent.github.io/helm-charts
helm repo update

echo "Installing fluentbit base components"

helm upgrade --install fluent-bit fluent/fluent-bit -n logging -f ../tools/fluent-bit/values-tmp.yaml
sleep 30

echo "Printing fluentbit status"
kubectl get pods -n logging
