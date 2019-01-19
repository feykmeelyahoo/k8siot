## Installed with the old method in CoreOS Operator git page which is deprecated now, However Redhat integration continues

https://github.com/coreos/prometheus-operator/tree/master/helm

# Install helm https://docs.helm.sh/using_helm/ then run:
helm repo add coreos https://s3-eu-west-1.amazonaws.com/coreos-charts/stable/
helm install coreos/prometheus-operator --name prometheus-operator --namespace monitoring
helm install coreos/kube-prometheus --name kube-prometheus --namespace monitoring

## New Chart we haven't used yet

https://github.com/helm/charts/tree/master/stable/prometheus-operator


## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
helm delete prometheus-operator
helm delete kube-prometheus
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

CRDs created by this chart are not removed by default and should be manually cleaned up:

```
kubectl delete crd prometheuses.monitoring.coreos.com
kubectl delete crd prometheusrules.monitoring.coreos.com
kubectl delete crd servicemonitors.monitoring.coreos.com
kubectl delete crd alertmanagers.monitoring.coreos.com
```

##
Stable One

helm install stable/prometheus-operator -f stable.values.yaml  --name prometheus-operator --namespace monitoring
