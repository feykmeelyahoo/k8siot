# Evreka K8S Setup Installation guide
Create a file named evreka-ns-yaml

```
kind: Namespace
apiVersion: v1

metadata:
  name: evreka
```

> kubectl apply -f evreka-ns-yaml

## ELK Installation guide
ELK docker run komutları 20181109 - KKK_Kurulum/elk altında makefile'da

curl "10.97.74.220:9200/_cluster/health?pretty=true"
curl "10.32.0.20:9200/_cluster/state?pretty=true"

## Set-Context
kubectl  config set-context evrContext --namespace evreka --user kubernetes-admin --cluster kubernetes
kubectl  config use-context evrContext
