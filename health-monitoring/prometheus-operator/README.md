### To Install vi Helm
```
kubens monitoring
cd ${secrets-dir}
kubectl create secret tls havelsan.io --key havelsan.io.key --cert havelsan.io.crt

helm repo update
helm fetch stable/prometheus-operator
tarr -zxf *.tar.gz
```
### If Needed, if any error Occurs 

```
kubectl apply -f https://raw.githubusercontent.com/coreos/prometheus-operator/master/example/prometheus-operator-crd/alertmanager.crd.yaml
kubectl apply -f https://raw.githubusercontent.com/coreos/prometheus-operator/master/example/prometheus-operator-crd/prometheus.crd.yaml
kubectl apply -f https://raw.githubusercontent.com/coreos/prometheus-operator/master/example/prometheus-operator-crd/prometheusrule.crd.yaml
kubectl apply -f https://raw.githubusercontent.com/coreos/prometheus-operator/master/example/prometheus-operator-crd/servicemonitor.crd.yaml
```

### Edit and rename values.yaml to myvalues.yaml

```
helm install . -n prometheus-operator --namespace monitoring --values myvalues.yaml
```
### To Delete 
```
helm delete -- purge prometheus-operator
```

CRDs created by this chart are not removed by default and should be manually cleaned up:

```
kubectl delete crd prometheuses.monitoring.coreos.com
kubectl delete crd prometheusrules.monitoring.coreos.com
kubectl delete crd servicemonitors.monitoring.coreos.com
kubectl delete crd alertmanagers.monitoring.coreos.com
```

##
Stable One

