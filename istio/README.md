## istio install
```
curl -L https://git.io/getLatestIstio | sh -
cd istio-1.0.5
export PATH=$PWD/bin:$PATH
```
### istio component'lerini ve crd'lerini kurmak için
```
helm install install/kubernetes/helm/istio --name istio --namespace istio-system
```
### istio component'lerini ve crd'lerini kaldırmak için
```
helm delete --purge istio
kubectl delete -f ./install/kubernetes/helm/istio/templates/crds.yaml
```
