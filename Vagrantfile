VAGRANTFILE_API_VERSION = "2"

$k8s_count=3

$k8s_memory=8192
$k8s_cpus=2

def workerIP(num)
  return "192.168.104.#{num+100}"
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.ssh.insert_key = false

config.vm.box = "bento/ubuntu-18.04"
  (1..$k8s_count).each do |i|
    config.vm.define vm_name = "k8s-0%d" % i do |node|
      node.vm.network :private_network, :ip => "#{workerIP(i)}"
      node.vm.hostname = vm_name
      node.vm.provider "virtualbox" do |v|
        if i == 1                       
          v.memory = 4096
          v.cpus = 2
        elsif i == 2                       
          v.memory = 10240
          v.cpus = 3
        else                            
          v.memory = 9216
          v.cpus = 3
        end                             
      end
      node.vm.provision "shell", inline: <<-SHELL
        apt-get update
        apt-get upgrade -y
        apt-get install -y zsh vim git mlocate ldap-utils gnutls-bin ssl-cert tmux nfs-common
        systemctl stop ufw
        systemctl disable ufw
    #    yum update -y
    #    yum install mlocate  -y
    #    yum install docker-ce  -y
    #    yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
    #    systemctl stop firewalld.service
    #    systemctl disable firewalld.service
    #    systemctl start docker
    #    systemctl enable docker
    #    usermod -aG docker vagrant
    #    updatedb
      SHELL
      node.vm.provision :shell, :path => "vagrantscripts/setLocale.sh"
      node.vm.provision :shell, :path => "vagrantscripts/shellVimExtras.sh"
      node.vm.provision :shell, :path => "vagrantscripts/shellVimExtras.sh", privileged: false
      # Change the vagrant user's shell to use zsh
      node.vm.provision :shell, inline: "chsh -s /bin/zsh vagrant"
      node.vm.provision :shell, :path => "vagrantscripts/bootstrap.sh", :args => "#{workerIP(i)}"
    end
  end
end
