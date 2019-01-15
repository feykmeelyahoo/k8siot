# Aşağıdaki linklere bak
DEPRECATED https://github.com/helm/charts/tree/master/stable/fluentd-elasticsearch
https://github.com/kiwigrid/helm-charts/tree/master/charts

# Buradan aşağısı eski yazdıklarım

# Elasticsearch Add-On 

***İlk önce bur adresteki açıklamaları okuyun!!!***>https://github.com/kubernetes/kubernetes/tree/master/cluster/addons/fluentd-elasticsearch


**Note:** Fluentd'nin çalışması için, her Kubernetes node'u labellanmalı
 `beta.kubernetes.io/fluentd-ds-ready=true`, yoksa  Fluentd
DaemonSet letiketsiz node'ları ignore eder.

### label eklemek için
```
for i in  `kubectl get nodes | cut -d ' ' -f 1  | grep k8s-` ; do kubectl label nodes ${i} beta.kubernetes.io/fluentd-ds-ready=true; done
```
### label kaldırmak için
```
for i in  `kubectl get nodes | cut -d ' ' -f 1  | grep k8s-` ; do kubectl label nodes ${i} beta.kubernetes.io/fluentd-ds-ready-; done 
```

**Note:** elasticserach'ün ihtiyaç duyduğu volume NFS ile verildi. Gerekli olursa değiştir.

### Known problems

Fluentd elasticsearch servisiyle konuştuğu ve masterların kube-proxy'si olmadığından master'daki podların logları toplanmaz.

___Don't mark masters
with the label mentioned in the previous paragraph or add a taint on them to
avoid Fluentd pods scheduling there.___

[fluentd]: http://www.fluentd.org/
[elasticsearch]: https://www.elastic.co/products/elasticsearch
[kibana]: https://www.elastic.co/products/kibana
[xPack]: https://www.elastic.co/products/x-pack
[setupCreds]: https://www.elastic.co/guide/en/x-pack/current/setting-up-authentication.html#reset-built-in-user-passwords
[fluentdCreds]: https://github.com/uken/fluent-plugin-elasticsearch#user-password-path-scheme-ssl_verify
[fluentdEnvVar]: https://docs.fluentd.org/v0.12/articles/faq#how-can-i-use-environment-variables-to-configure-parameters-dynamically
[configMap]: https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/
[secret]: https://kubernetes.io/docs/concepts/configuration/secret/
[statefulSet]: https://kubernetes.io/docs/concepts/workloads/controllers/statefulset
[initContainer]: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/
[emptyDir]: https://kubernetes.io/docs/concepts/storage/volumes#emptydir
[daemonSet]: https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/
[k8sElasticsearchDocs]: https://kubernetes.io/docs/tasks/debug-application-cluster/logging-elasticsearch-kibana

[![Analytics](https://kubernetes-site.appspot.com/UA-36037335-10/GitHub/cluster/addons/fluentd-elasticsearch/README.md?pixel)]()
