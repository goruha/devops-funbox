package 'expect'
package 'oathtool'

cookbook_file '/usr/local/bin/ssh-2fa' do
  source 'ssh-2fa.sh'
  mode '0755'
  action :create
end


remote_file '/home/vagrant/.ssh/id_rsa' do
  source 'https://github.com/phusion/baseimage-docker/raw/master/image/services/sshd/keys/insecure_key'
  owner 'vagrant'
  group 'vagrant'
  mode '0600'
  action :create
end
