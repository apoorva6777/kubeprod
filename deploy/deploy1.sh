cd ..
cd kustomize-test
cd base
kubectl apply -f namespace.yaml
kubectl apply -f service-account-details.yaml
kubectl apply -f service-account-product.yaml
kubectl apply -f service-account-ratings.yaml
sleep 10
kubectl apply -f policy.yaml
kubectl apply -f cluster-role-binding.yaml
sleep 20
kubectl apply -f details.yaml
kubectl apply -f ratings.yaml
kubectl apply -f details-service.yaml
kubectl apply -f ratings-service.yaml
sleep 90
kubectl get pods -n dev

kubectl apply -f product.yaml
sleep 90
kubectl get pods -n dev
sleep 20
kubectl get pods -n dev
kubectl apply -f product-service.yaml
kubectl apply -f ingress.yaml

