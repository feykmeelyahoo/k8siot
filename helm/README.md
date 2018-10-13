# Helm

Helm, kubectl'in kullandığı (genelde $HOME/.kube/config) kubeconfig'e bakarak ilgili kubernetes cluster'ına kurulum yapar.

## Helm Kurulumu
https://docs.helm.sh/using_helm/#installing-helm

```
kubectl apply -f rbac-tiller.yaml   # bizde helm directory'sinde bulunuyor
helm init --service-account tiller  
```
```
watch kubectl get pods,svc,pv --all-namespaces -o wide
```

## Reset Tiller

helm reset
rm -rf ~/.helm
kubectl delete -f rbac-tiller.yaml   # bizde helm directory'sinde bulunuyor

kubectl get pods,svc,pv --all-namespaces -o wide

pod, deployment and svc silindiğinden emin ol..
