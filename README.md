## useful plugins for auto completion to be inserted in .zshrc

> git helm docker docker-compose docker-machine kubectl kube-ps1 zsh-autosuggestions  
source ~/.kubectl_aliases

## if two NICs available do the following for all k8s nodes and masters
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

## delete k8s cluster
```
kubeadm reset
```
>restart all nodes

>remove directories /etc/kubernetes except manifests directory and /var/lib/kubelet/*

```
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```
## to print the join command for clients. do on master
```
kubeadm token create --print-join-command
kubectl get nodes k8s-01 -o yaml | more
```

## helm
```
kubectal apply <helm-rbac-yaml>
helm init --service-account tiller
```
