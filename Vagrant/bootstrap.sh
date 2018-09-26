#!/usr/bin/env bash
# check if a go version is set

sudo apt-get update
sudo apt-get upgrade -y

docker ps > /dev/null 2>&1
DOCKER_INSTALLED=$?

if [ $DOCKER_INSTALLED -eq 0 ]; then
    echo "Docker Already Installed"
else
    echo ">>> Installing docker"
    # sudo swapoff -a
   
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
   #"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   sudo add-apt-repository "deb https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable" 
    sudo sed -i '/ swap / s/^/#/' /etc/fstab
    sudo apt-get update
    sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    zsh
    sudo apt-get install -y docker-ce=$(apt-cache madison docker-ce | grep 17.03 | head -1 | awk '{print $3}')
    sudo apt-mark hold docker-ce
    echo ">>> Adding vagrant user to docker group"
    sudo usermod -aG docker vagrant
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
#    sudo  sed -i '  git/c\  docker git docker-machine docker-compose kubectl kube-ps1' ~/.zshrc
fi

kubeadm > /dev/null 2>&1
KUBEADM_INSTALLED=$?

if [ $KUBEADM_INSTALLED -eq 0 ]; then
    echo "Kubeadm Already Installed"
else
    echo ">>> Installing Kubeadm"
    sudo apt-get update && apt-get install -y apt-transport-https curl
    sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

    sudo bash -c 'cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF'
    sudo apt-get update
    sudo apt-get install -y kubelet kubeadm kubectl
    sudo apt-mark hold kubelet kubeadm kubectl

    sudo shutdown now -r
fi
