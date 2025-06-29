# Prometheus-Grafana
This repository contains step-by-step instructions to set up a Prometheus and Grafana monitoring stack on WSL with Minikube.

# Prerequisites

WSL2 is installed and configured
Docker is installed in WSL
Minikube is installed in WSL
kubectl installed
Helm installed

1. Start Minikube

minikube start --driver=docker

2. Enable Minikube Addons
   
bashminikube addons enable metrics-server

4. Install Helm (if not already installed)
   
bashcurl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

6. Add Prometheus Helm Repository
   
bashhelm repo add prometheus-community https://prometheus-community.github.io/helm-charts

helm repo update

8. Install Prometheus Stack
   
bashkubectl create namespace monitoring

helm install prometheus prometheus-community/kube-prometheus-stack -n monitoring

10. Verify Installation
    
bashkubectl get pods -n monitoring
kubectl get svc -n monitoring

11. Configure NodePort for Permanent Access
Set Prometheus NodePort
kubectl patch svc prometheus-kube-prometheus-prometheus -n monitoring -p '{"spec": {"type": "NodePort"}}'
Set Grafana NodePort
kubectl patch svc prometheus-grafana -n monitoring -p '{"spec": {"type": "NodePort"}}'

ACCESS METHOD:

1. Create monitoringurls.sh
2. Make it exectable
    chmod 700 monitoringurls.sh
3. Login to the prometheus using the site we got, after we executed the file
4. Login to graghana using the credentails below by passing the command
   kubectl get secret -n monitoring prometheus-grafana -o jsonpath="{.data.admin-password}" | base64 --decode && echo
5. Username is admin
6. Yes we did it!!!!!

We can add prometheus as data source to graphana, as graphana is the pictorial representation of premotheus data
   
Configure Prometheus Data Source

Login to Grafana
Go to Configuration → Data Sources
Add Prometheus data source
URL: http://prometheus-kube-prometheus-prometheus.monitoring.svc.cluster.local:9090
Save & Test

Import Dashboards
Popular Dashboard IDs to import:

3662 - Prometheus 2.0 Overview
1860 - Node Exporter Full
6417 - Kubernetes Cluster Monitoring
8588 - Kubernetes Deployment Statefulset Daemonset metrics


