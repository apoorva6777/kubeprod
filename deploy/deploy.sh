cd ..
cd infra/kubernetes
terraform init
terraform apply --auto-approve

echo "Kubernetes cluster and associated resources provisioned"
# CLUSTER CONNECT
CLUSTER_ID=$(terraform output -raw k8s-cluster-id)

NODE_POOL_1=$(terraform output k8s-node-pool-id-one)
NODE_POOL_1="${NODE_POOL_1%\"}"
NODE_POOL_1="${NODE_POOL_1#\"}"

NODE_POOL_2=$(terraform output k8s-node-pool-id-two)
NODE_POOL_2="${NODE_POOL_2%\"}"
NODE_POOL_2="${NODE_POOL_2#\"}"


oci ce cluster create-kubeconfig --cluster-id $CLUSTER_ID --file $HOME/.kube/config --region us-ashburn-1 --token-version 2.0.0 --kube-endpoint PUBLIC_ENDPOINT
export KUBECONFIG=$HOME/.kube/config
kubectl get service
sleep 120
echo "Connection to kubernetes cluster successful"

cd ../..
cd scripts

# Cluster Metric
echo "deploying cluster metric server"
kubectl apply -f metric-server.yaml
sleep 30
kubectl -n kube-system get deployment/metrics-server
echo "cluster metric deployed"


# Cluster Autoscaler
echo "Replacing node pool OCID value in autoscaler yaml"
sed -E "s|<REPLACE_WITH_DYNAMIC_VALUE_NODE_POOL_1>|$NODE_POOL_1|g; s|<REPLACE_WITH_DYNAMIC_VALUE_NODE_POOL_2>|$NODE_POOL_2|g" autoscaler.yaml > cluster-autoscaler.yaml
echo "Deploying cluster autoscaler in cluster"
kubectl apply -f cluster-autoscaler.yaml
sleep 30
kubectl -n kube-system get cm cluster-autoscaler-status -oyaml    
echo "Cluster Autoscaler deployed"

# ISTIO
echo "moving to Istio folder"
source ../tools/istio/istio.sh

echo "Istio Ingress gateway Exposed on $ISTIO_EXTERNAL_IP"
echo "Istio setup Done"

sleep 30

# # KYVERNO
# echo "moving to Kyverno folder"
# source ../tools/kyverno/kyverno.sh
# echo "Kyverno setup done moving on to next"

# sleep 30


# # ArgoCD
# echo "moving to ArgoCD folder"
# source ../tools/argocd/argocd.sh
# echo "ArgoCD setup done moving on to next"
# echo "The initial admin password is: $ARGOCD_PASSWORD"


# sleep 30
# # FluentBit

# API_KEY="829ab611c3bb058571ddc8bf17c18eb1c138NRAL"
# sed "s/API_KEY_PLACEHOLDER/${API_KEY}/g" ../tools/fluent-bit/values.yaml > ../tools/fluent-bit/values-tmp.yaml
# echo "moving to Fluentbit folder"
# source ../tools/fluent-bit/fluent.sh
# echo "ArgoCD setup done moving on to next"

# sleep 30

# # Prometheus AlertManager and Grafana setup
# echo "Moving to Monitoring Folder"
# source ../tools/monitoring/monitoring.sh
# echo "Monitoring setup done moving on to next"


# echo "Grafana accessible at http://$GRAFANA_EXTERNAL_IP:3000"
# echo "Prometheus accessible at http://$PROMETHEUS_EXTERNAL_IP:9090"


# sleep 30







