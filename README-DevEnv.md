## useful plugins for auto completion to be inserted in .zshrc

```
wget https://raw.githubusercontent.com/ahmetb/kubectl-aliases/master/.kubectl_aliases
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```
> git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

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
# Create a custom JavaScript prompt section
# POWERLEVEL9K_CUSTOM_JAVASCRIPT="echo -n '\ue781' JavaScript"
POWERLEVEL9K_CUSTOM_JAVASCRIPT="echo -n '\ue781'"
POWERLEVEL9K_CUSTOM_JAVASCRIPT_FOREGROUND="black"
POWERLEVEL9K_CUSTOM_JAVASCRIPT_BACKGROUND="yellow"

```
### Add below lines to .zshrc
git helm docker docker-compose docker-machine kubectl kube-ps1 zsh-autosuggestions zsh-syntax-highlighting vagrant vagrant-prompt

source ~/.kubectl_aliases

### Install kubectx and kubens
sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
sudo ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
sudo ln -s /opt/kubectx/kubens /usr/local/bin/kubens

mkdir -p ~/.oh-my-zsh/completions
chmod -R 755 ~/.oh-my-zsh/completions
ln -s /opt/kubectx/completion/kubectx.zsh ~/.oh-my-zsh/completions/_kubectx.zsh
ln -s /opt/kubectx/completion/kubens.zsh ~/.oh-my-zsh/completions/_kubens.zsh

### Install Helm

wget https://storage.googleapis.com/kubernetes-helm/helm-v2.12.1-linux-amd64.tar.gz
tar -zxf helm-v2.12.1-linux-amd64.tar.gz
cd linux-amd64
sudo mv tiller helm /usr/local/bin

### Apply Helm RBACs
```

cat <<EOF | kubectl create -f -
apiVersion: v1
kind: ServiceAccount
metadata:
  name: tiller
  namespace: kube-system
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: tiller
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
  - kind: ServiceAccount
    name: tiller
    namespace: kube-system
EOF
```
>helm init --service-account tiller  
## Reset Tiller
```console
helm reset
rm -rf ~/.helm
kubectl delete -f rbac-tiller.yaml   # bizde helm directory'sinde bulunuyor
```
## Activate auto oh_my_zsh auto completions 
## Add after plugins and source ohmyzsh
```console
autoload -U compinit
compinit
```

## Vagrant box oluşturma-- sonrasında hosts ve /etc/default/kubeleti editle
```console
vagrant package --base <<preconfigured_vm>> --output mybox.box
vagrant box add --name="boxname" mybox.box
```
## Vagrant default: Warning: Authentication failure. Retrying...
```console
wget --no-check-certificate https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub -O /home/vagrant/.ssh/authorized_keys  
chmod 0700 /home/vagrant/.ssh 
chmod 0600 /home/vagrant/.ssh/authorized_keys  
chown -R vagrant /home/vagrant/.ssh
```
