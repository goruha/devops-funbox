unless Vagrant.has_plugin?("vagrant-berkshelf")
  raise 'Install vagrant-berkshelf with command $ vagrant plugin install vagrant-berkshelf'
end


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

  iptablesConfig = <<-EOT
# Generated by iptables-save v1.4.21 on Tue Jun 14 15:41:38 2016
*filter
:INPUT ACCEPT [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
COMMIT
# Completed on Tue Jun 14 15:41:38 2016
  EOT

  $script = <<SCRIPT
  if [ -f /etc/network/if-up.d/dns-scrambler ]; then
echo "#{iptablesConfig}" > /etc/iptables/rules.v4
rm -rf /etc/network/if-up.d/dns-router
rm -rf /etc/network/if-up.d/dns-scrambler
sudo /etc/init.d/iptables-persistent restart
sudo iptables -t nat -F
sudo ip route del 8.8.8.8
sudo ip route del 8.8.4.4
sudo ip route del 10.0.2.3
sudo ip route add default via 10.0.2.2 dev eth0
fi
SCRIPT

  config.vm.provision "shell", inline: $script

  config.vm.provision "chef_solo" do |chef|
    chef.install            = false
#    chef.cookbooks_path     = "cookbooks"
    chef.roles_path         = "roles"
    chef.add_role("devops")
  end

end
