kubectl create -f postgres-secret.yaml
kubectl apply -f postgres-db-pv.yaml
kubectl apply -f postgres-db-pvc.yaml
kubectl apply -f postgres-db-deployment.yaml
kubectl apply -f postgres-db-service.yaml
