#!/bin/bash
# check if a go version is set

clear
echo $0 $1

apt-get update
apt-get upgrade -y
apt-get install -y zsh vim git mlocate ldap-utils gnutls-bin ssl-cert tmux

ls /usr/local/share/ca-certificates/PCAcer.crt > /dev/null 2>&1
CERT_INSTALLED=$?

if [ $CERT_INSTALLED -eq 0 ]; then
    echo "Cert Already Installed"
else
    echo "Installing Cert"
    sudo cp /vagrant/PCAcer.crt /usr/local/share/ca-certificates
    sudo update-ca-certificates 

    HOSTNAME=$(hostname)
    sudo sed -i '/'${HOSTNAME}'/d' /etc/hosts
fi

docker ps > /dev/null 2>&1
DOCKER_INSTALLED=$?

if [ $DOCKER_INSTALLED -eq 0 ]; then
    echo "Docker Already Installed"
else
    echo ">>> Installing docker"
    sudo apt-get install -y docker.io
    echo ">>> Adding vagrant user to docker group"
    sudo usermod -aG docker vagrant
fi

kubeadm > /dev/null 2>&1
KUBEADM_INSTALLED=$?

if [ $KUBEADM_INSTALLED -eq 0 ]; then
    echo "Kubeadm Already Installed"
else
    echo ">>> Installing Kubeadm"
    apt-get update && apt-get install -y apt-transport-https curl
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

    bash -c 'cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF'
    apt-get update
    apt-get install -y kubelet kubeadm kubectl
    apt-mark hold kubelet kubeadm kubectl

    kubeletPlace=$(find /etc -name kubelet -exec bash -c  "echo {}" \;)      
    myIP=$1
    sed  -i $'/KUBELET_EXTRA_ARGS/c KUBELET_EXTRA_ARGS=  --node-ip='${myIP}'' $kubeletPlace

    echo  Europe/Istanbul > /etc/timezone
    
    sudo swapoff -a
    sudo sed -i '/ swap / s/^/#/' /etc/fstab    
    
    echo ">>> Do vagrant reload !!!"
    # sudo shutdown now -r
fi

