## useful plugins for auto completion to be inserted in .zshrc

```
wget https://raw.githubusercontent.com/ahmetb/kubectl-aliases/master/.kubectl_aliases
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```
> git helm docker docker-compose docker-machine kubectl kube-ps1 zsh-autosuggestions zsh-syntax-highlighting vagrant vagrant-prompt

> source ~/.kubectl_aliases

## if two NICs available add the following for all k8s nodes and masters
> vi /etc/systemd/system/kubelet.service.d/10-kubeadm.conf yada  /etc/sysconfig/kubelet içerisine

> "--node-ip=192.17.8.101"  # change the with your the IP of with the IP your desired NIC

```
systemctl daemon-reload
```

## start the master, change --apiserver-advertise-address=192.17.8.101 if necessary # change the with your the IP of with the IP your desired NIC
```console
kubeadm config images pull #optional
kubeadm init --apiserver-advertise-address=192.17.8.101 --pod-network-cidr=192.168.0.0/16 # change the with your the IP of with the IP your desired NIC
```
## to make kubeadm master a scheduleable node 
```
kubectl taint node k8s-01 node-role.kubernetes.io/master:NoSchedule-
```

## delete k8s cluster
```
kubeadm reset

docker stop $(docker ps -aq)
docker rm $(docker ps -aq)
docker rmi $(docker images -aq)

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
helm install stable/nfs-server-provisioner --name mynfs --values myValues.yaml
```