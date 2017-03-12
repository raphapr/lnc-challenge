# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "geerlingguy/ubuntu1604"
  config.vm.network "forwarded_port", guest: 3000, host: 3000
  config.vm.network "forwarded_port", guest: 443, host: 4433
  config.vm.network "forwarded_port", guest: 80, host: 8080

  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
 
    # Customize the amount of memory on the VM:
    vb.memory = "1048"
    vb.cpus = 2
  end

   config.vm.provision "shell", inline: <<-SHELL
    apt-add-repository ppa:ansible/ansible
    apt-get update
    apt-get install -y tmux ansible
    wget bit.ly/rprtmux -O /home/vagrant/.tmux.conf
   SHELL

end
