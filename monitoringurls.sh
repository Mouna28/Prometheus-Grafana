#!/bin/bash



echo "Monitoring Services URLs:"
echo "=========================="
echo "Prometheus:"
minikube service prometheus-kube-prometheus-prometheus -n monitoring --url &
echo ""
echo "Grafana:"
minikube service prometheus-grafana -n monitoring --url &
echo "=========================="
