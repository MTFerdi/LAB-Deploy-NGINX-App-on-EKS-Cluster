# NGINX on Amazon EKS — Lab Assets

This repo contains the YAML manifests and notes for deploying a basic NGINX web server on an existing Amazon EKS cluster.

## Files

- `k8s/deployment.yaml` — Kubernetes Deployment for NGINX
- `k8s/service.yaml` — LoadBalancer Service to expose NGINX publicly
- `scripts/cleanup.sh` — Convenience script to delete the Service and Deployment
- `README.md` — This file with usage tips

## Prereqs

- `kubectl` configured to point to your EKS cluster
- Nodes are `Ready` (`kubectl get nodes`)
- You have permissions to create Service type `LoadBalancer`

## Apply

```bash
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml

kubectl get deployments
kubectl get pods -o wide
kubectl get svc nginx-service -w
```

Once `EXTERNAL-IP` is assigned:
```bash
curl http://<EXTERNAL-IP>
```

## Scale

```bash
kubectl scale deployment nginx-deployment --replicas=3
kubectl get pods -o wide
```

## Cleanup

```bash
./scripts/cleanup.sh
```

## Exporting Manifests from your current cluster (optional)

If you created resources with `kubectl create/ expose` and want to capture the *clean* manifest versions:

```bash
# Generate client-side YAMLs (no status/cluster fields)
kubectl create deployment nginx-deployment --image=nginx:latest \
  --dry-run=client -o yaml > k8s/deployment.yaml

kubectl expose deployment nginx-deployment --type=LoadBalancer --port=80 --name=nginx-service \
  --dry-run=client -o yaml > k8s/service.yaml
```

```
