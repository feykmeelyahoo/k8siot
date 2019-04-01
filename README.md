## if two NICs available add the following for all k8s nodes and masters
vi /etc/systemd/system/kubelet.service.d/10-kubeadm.conf yada  /etc/sysconfig/kubelet içerisine

> "--node-ip=192.168.104.101"  # change the with your the IP of with the IP your desired NIC
=======

```
systemctl daemon-reload
```

## start the master, change --apiserver-advertise-address=192.17.8.101 if necessary # change the with your the IP of with the IP your desired NIC
```console
kubeadm config images pull #optional
kubeadm init --apiserver-advertise-address=192.168.104.101 --pod-network-cidr=192.168.0.0/16 # change the with your the IP of with the IP your desired NIC
sudo kubeadm init --apiserver-advertise-address 192.168.104.41 --service-dns-domain cluster.havelsan --pod-network-cidr 192.168.0.0/16
```
## to make kubeadm master a scheduleable node 
```
kubectl taint node k8s-01 node-role.kubernetes.io/master:NoSchedule-
```

## delete k8s cluster
```
kubeadm reset

systemctl stop kubelet.service    
docker stop $(docker ps -aq)
docker rm $(docker ps -aq)
docker rmi $(docker images -aq)
docker volume prune
```
>restart all nodes

>remove directories /etc/kubernetes except manifests directory and /var/lib/kubelet/*
>sudo rm -rf /etc/kubernetes /var/lib/kubelet /var/lib/etcd             
```
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```
### to print the join command for clients. do on master
```
kubeadm token create --print-join-command
kubectl get nodes k8s-01 -o yaml | more
```

### helm
```
kubectal apply <helm-rbac-yaml>
helm init --service-account tiller
```

### to apply a label to node 
```
kubectl label nodes k8s-01 node-role.kubernetes.io/node=
```

### to remove a label to node 
```
kubectl label nodes k8s-01 node-role.kubernetes.io/node-
```
### to Set locale
```
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
sudo dpkg-reconfigure locales
```
### sample namespace yaml

```
kind: Namespace
apiVersion: v1
metadata:
  name: mynamespace
```
```
kubectl config --help
kubectl config get-contexts
kubectl config current-context
kubectl config set-context $(kubectl config current-context --namespace=mynamespace)
kubectl config view
kubectl config get-contexts
```

### nfs provisioner installation
```
helm install stable/nfs-server-provisioner --name mynfs --values myValues.yaml --namespace storage
```

#### uninstall everthing ####

```
apt-get remove kubeadm kubelet kubectl docker-ce
apt-get purge kubeadm kubelet kubectl docker-ce

rm -rf /var/lib/docker
rm -rf /var/lib/dockershim
rm -rf /var/lib/kubelet
rm -rf /etc/docker
```
### kubectl proxy

```
kubectl proxy
http://127.0.0.1:8001/api/v1/namespaces/kube-system/services/kubernetes-dashboard:80/proxy/#!/overview?namespace=default
http://127.0.0.1:8001/api/v1/namespaces/weave/services/weave-scope-app:80/proxy/
```

#### harbor secret creation ####
```
kubectl create secret docker-registry harbor \           
--docker-server=https://10.151.17.110 \
--docker-username=admin \
--docker-email=admin@admin.com\
--docker-password='Harbor12345'
```
> #### Example harbor secret usage ####

```
apiVersion: v1
kind: Pod
metadata:
  name: cassandra-setup
spec:
  containers:
  - name: cassandra-setup
    imagePullPolicy: Always
    image: 10.151.17.110/botas/thingsboard/cassandra-setup:2.1.0
    env:
    - name: ADD_DEMO_DATA
      value: "true"
    - name : CASSANDRA_HOST
      value: "cassandra-headless"
    - name : CASSANDRA_PORT
      value: "9042"
    - name : DATABASE_TYPE
      value: "cassandra"
    - name : CASSANDRA_URL
      value: "cassandra-headless:9042"
    command:
    - sh
    - -c
    - /install.sh
  restartPolicy: Never
  imagePullSecrets:
  - name: harbor
```

### Troubleshooting Tip
namespaceleri silemiyor idim özellikle kubevirt. Apiserver ve controller managerda bir dolu log dönüyor idi.
kubectl get apiservices --all-namespaces| grep virt  
kubectl delete apiservices v1alpha2.subresources.kubevirt.io

yapınca dzeldi.

Anlaşılan atılan apilar kalmıştı ve bunlar ns silinmesine engel oluyor idi.

> ### Difference Between port, targetPort and nodePort
https://stackoverflow.com/questions/49981601/difference-between-targetport-and-port-in-kubernetes-service-definition
```
  apiVersion: v1
  kind: Service
  metadata:
    name: test-service
  spec:
    ports:
    - port: 8080
      targetPort: 8170 # containerPort On Pods defined in deploymant, statefulset etc...
      nodePort: 33333
      protocol: TCP 
    selector:
      component: test-service-app
```
Pay attention to some of the following in above spec:

The port is 8080 which represents that test-service can be accessed by other services in the cluster at port 8080. The targetPort is 8170 which represents the test-service is actually running on port 8170 on pods The nodePort is 33333 which represents that test-service can be accessed via kube-proxy on port 33333.

> #### Q&A 
> Question - Reading some of the comments in the client code, they mention that targetPort is optional. So how does kubernetes decide what port of the pod to expose? Does it default to a particular value?
> 
> Answer - "By default the targetPort will be set to the same value as the port field." (kubernetes.io/docs/concepts/services-networking/service/…). So by default, Kubernetes assumes the port that's exposed inside the cluster, is the same as the port exposed directly by the pod.
>

### DNS resolution için  (Ubuntu 18.04)
> 1- Kubernetes nodelarından bir tanesine geç
> 2- vi /etc/systemd/resolved.conf
>    DNS=10.96.0.10
>    Domains=cluster.havelsan default.svc.cluster.havelsan kube-system.svc.cluster.havelsan egys.svc.cluster.havelsan
> 3-  /etc/resolv.conf -> /run/systemd/resolve/resolv.conf a linkle
> 4- reboot

### Clustername Değişince weave scpoe açılmadı
> Adamlar yaml içine hardcoded cluster.local yazmışlar 
> Yeni isimle değiştirince çalıştı

### when delete pv stucks

> kubectl patch pv pvc-9f02c323-3ffd-11e9-bacc-566f555f0001 -p '{"metadata":{"finalizers":null}}'


### Pod Eviction Timeout values for kube controller manager
```
--node-monitor-period=2s (default 5s)
--node-monitor-grace-period=16s (default 40s)
--pod-eviction-timeout=30s (default 5m)
```
