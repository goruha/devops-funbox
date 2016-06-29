Vagrant.configure(2) do |config|
  config.vm.box = "ervin/devops-box"

  config.ssh.forward_agent = true
  config.ssh.username = 'vagrant'
  config.ssh.password = 'vagrant'
  config.ssh.insert_key = true

  config.vm.provider "virtualbox" do |vb|
  vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.gui = false
    vb.memory = "1024"
  end

  config.vm.hostname = "renderedtext"
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  config.vm.provision "chef_solo" do |chef|
    chef.install            = false
    chef.cookbooks_path     = "cookbooks"
    chef.roles_path         = "roles"
    chef.add_role("devops")
  end

end
