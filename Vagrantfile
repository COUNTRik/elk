# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "centos/7"

  config.vm.provision "ansible" do |ansible|
   # ansible.verbose = "v"
   ansible.playbook = "playbooks/install.yml"
   ansible.become = "true"
  end

  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 2
  end

  config.vm.define "logs" do |logs|
    logs.vm.network "private_network", ip: "192.168.50.10", virtualbox__intnet: "net1"
    logs.vm.hostname = "logs"
    # logs.vm.provision "shell", path: "scripts/nfs_server.sh"
  end

  config.vm.define "web" do |web|
    web.vm.network "private_network", ip: "192.168.50.11", virtualbox__intnet: "net1"
    web.vm.hostname = "web"
    # web.vm.provision "shell", path: "scripts/nfs_client.sh"
  end

end
