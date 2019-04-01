VAGRANTFILE_API_VERSION = "2"

$k8s_count=3
$k8s_memory=8192
$k8s_cpus=4
$startingIp=50

def hostPrefix()
  return "k8s-0"
end

def ipPrefix()
  return "172.17.8."
end

def workerIP(num)
  return "#{ipPrefix()}#{num+$startingIp}"
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.ssh.insert_key = false

#  config.vm.box = "bento/ubuntu-18.04"
  config.vm.box = "basdemirs/ub1804-k8s-14.0"
  (1..$k8s_count).each do |i|
    config.vm.define vm_name = "#{hostPrefix()}%d" % i do |node|
      node.vm.network :private_network, :ip => "#{workerIP(i)}"
      node.vm.hostname = vm_name
      if i == 2
        node.vm.network "forwarded_port", guest: 31080, host: 31080, protocol: "tcp",
          auto_correct: true
        node.vm.network "forwarded_port", guest: 31215, host: 31215, protocol: "tcp",
          auto_correct: true
      end
      node.vm.provider "virtualbox" do |v|
        if i == 1                       
          v.memory = 4096
          v.cpus = 2
        elsif i == 2                       
          v.memory = 8192
          v.cpus = 3
        else                            
          v.memory = $k8s_memory
          v.cpus = $k8s_cpus
        end                             
      end
      node.vm.provision "shell", inline: <<-SHELL
      apt-get update
      apt install kubeadm kubectl kubelet kubernetes-cni -y
      apt-get upgrade -y
      SHELL
      node.vm.provision :shell, :path => "vagrantscripts/minimal.sh", :args => ["#{workerIP(i)}", "#$startingIp", "#$k8s_count", "#{ipPrefix()}", "#{hostPrefix()}"]
    end
  end
end
