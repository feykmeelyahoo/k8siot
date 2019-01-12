## useful plugins for auto completion to be inserted in .zshrc

```
wget https://raw.githubusercontent.com/ahmetb/kubectl-aliases/master/.kubectl_aliases
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

```
ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_MODE='nerdfont-complete'

# Customise the Powerlevel9k prompts
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  os_icon
  dir
  vcs
#  newline
#  custom_javascript
  status
)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
### Create a custom JavaScript prompt section
### POWERLEVEL9K_CUSTOM_JAVASCRIPT="echo -n '\ue781' JavaScript"
> POWERLEVEL9K_CUSTOM_JAVASCRIPT="echo -n '\ue781'"
POWERLEVEL9K_CUSTOM_JAVASCRIPT_FOREGROUND="black"
POWERLEVEL9K_CUSTOM_JAVASCRIPT_BACKGROUND="yellow"

### .zshrc içine ekle 
```
git helm docker docker-compose docker-machine kubectl kube-ps1 zsh-autosuggestions zsh-syntax-highlighting vagrant vagrant-prompt

source ~/.kubectl_aliases

## if two NICs available add the following for all k8s nodes and masters
vi /etc/systemd/system/kubelet.service.d/10-kubeadm.conf yada  /etc/sysconfig/kubelet içerisine

"--node-ip=192.17.8.101"  # change the with your the IP of with the IP your desired NIC

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
