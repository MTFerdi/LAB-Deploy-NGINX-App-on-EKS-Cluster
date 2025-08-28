#!/usr/bin/env bash
set -euo pipefail

kubectl delete svc nginx-service --ignore-not-found
kubectl delete deployment nginx-deployment --ignore-not-found
echo "Cleanup complete."
