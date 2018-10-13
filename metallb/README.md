## MetalLB Kurulumu

***Güncel kurulum için https://metallb.universe.tf/installation/ sitesine bakın***

>metallb.yaml indirin...

```
kubectl apply -f metallb.yaml
```

> Tek adrese bağlanması için

```
kubectl apply -f layer2.config.yaml
```