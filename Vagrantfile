# 
# Description: Creates an Oracle Linux Cloud Native Developer VM
# 
# 

# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# define hostname
NAME = "ksplice-demo"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ol7-latest"
  config.vm.box_url = "https://yum.oracle.com/boxes/oraclelinux/latest/ol7-latest.box"
  config.vm.define NAME
  
  config.vm.box_check_update = false
  
  # change memory size
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.name = NAME
    v.customize ["modifyvm", :id, "--vram", "128"]
  end

  # VM hostname
  config.vm.hostname = NAME
  # Port fowarding 
  config.vm.network "forwarded_port", guest: 80, host: 8000

  # Provision everything on the first run
  config.vm.provision "shell", path: "scripts/install.sh"

  end

