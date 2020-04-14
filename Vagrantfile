# 
# Description: Creates an Oracle Linux VM for Ksplice Demo
# 
# 

# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# define hostname
NAME = "ksplice-demo"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  if Vagrant.has_plugin?("vagrant-vbguest")
    config.vbguest.auto_update = false
  end

  config.vm.box = "ol8.0-latest"
  config.vm.box_url = "https://yum.oracle.com/boxes/oraclelinux/ol80/ol80.box"
  config.vm.define NAME
  
  config.vm.box_check_update = false
  
  # change memory size
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.name = NAME
    v.customize ["modifyvm", :id, "--graphicscontroller", "vmsvga"]
    v.customize ["modifyvm", :id, "--vram", "128"]
    v.customize ["modifyvm", :id, "--nictype1", "virtio"]
    v.customize ["modifyvm", :id, "--nictype2", "virtio"]
   end

  # VM hostname
  config.vm.hostname = NAME
  # Port fowarding 
  config.vm.network "forwarded_port", guest: 80, host: 8000

  # Provision everything on the first run
  config.vm.provision "shell", path: "scripts/install.sh"

  end


