# Kubernetes Ingress
 
ingress controller en çok __NodePort, LoadBalancer__ servisleri üzerinden kurulur.

On Prem LoadBalancer ile çalışmak için **(Google) MetalLB** güzel bir seçenektir.

## NodePort ile çalışırken

1. Ingress Deployment yada Statefulset içerisinde __hostNetwork: true__ yapılırsa podlar direk fiziksel interfacelere bağlanabilir. *Çok tavsiye edilmiyor.*
2. Üstteki işlem yapılmaksızın ingress tanımlarında verdiğimiz hostlar kubernetes nodelarından herhangi birini resolve edecek şekilde, ya dns yada hosts dosyasına yazılır.

   * Örn: 172.17.8.101	k8s-01 kubernetes-dashboard.hvl.com # k8s-01 bir kubernetes node'udur.

   * Web'den ulaşılacağı zaman kubernetes ingress controller service'inin NodePort'u ilave edilir..
  Örn 

```
 kubectl -n ingress-nginx get svc 

 ingress-nginx   NodePort   10.105.223.249   <none>        80:32066/TCP,443:30457/TCP   25m
```
görülür.

> http://kubernetes-dashboard.hvl.com:32066 ile dashboard açılır


## LoadBalancer ile çalışırken

Loadbalancer bulut sağlayıcılarının verdiği bir hizmetken on-prem'de Metallb ile hayat buldu. Metallb kendisine nelirlenen pooldan bir IP'yi Ingress'e atar bu sayede tek IP üzerinden faklı isimler ile istenen servislere bağlanılır.

# nginx-ingress kurulumu

>Web1: https://github.com/kubernetes/ingress-nginx
>
>Web12: https://kubernetes.github.io/ingress-nginx/

