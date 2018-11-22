## useful plugins for auto completion to be inserted in .zshrc

> git helm docker docker-compose docker-machine kubectl kube-ps1 zsh-autosuggestions vagrant vagrant-prompt go golang zsh-syntax-highlighting node npm nvm

> source ~/.kubectl_aliases

## if two NICs available add the following for all k8s nodes and masters
> vi /etc/systemd/system/kubelet.service.d/10-kubeadm.conf

> "--node-ip=172.17.8.101"

```
systemctl daemon-reload
```

## start the master, change --apiserver-advertise-address=172.17.8.101 if necessary
```console
kubeadm config images pull #optional
kubeadm init --apiserver-advertise-address=172.17.8.101 --pod-network-cidr=192.168.0.0/16
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
kubectl config set-context $(kubectl config current-context --namespace=mynamespace
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

#### harbor secret creation ####
```
kubectl create secret docker-registry harbor \           
--docker-server=https://10.151.17.110 \
--docker-username=admin \
--docker-email=admin@admin.com\
--docker-password='Harbor12345'
```
####Example harbor secret usage ####

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
