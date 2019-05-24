# SİLMEK için

helm delete --purge prometheus-operator

kubectl delete crd prometheuses.monitoring.coreos.com
kubectl delete crd prometheusrules.monitoring.coreos.com
kubectl delete crd servicemonitors.monitoring.coreos.com
kubectl delete crd alertmanagers.monitoring.coreos.com


# OLUŞTURMAK için
./createCRDS.sh

helm install --name prometheus-operator --set grafana.adminPassword='prom' --namespace monitoring  -f ./prometheus-operator-5.2.0/values.yaml ./prometheus-operator-5.2.0

