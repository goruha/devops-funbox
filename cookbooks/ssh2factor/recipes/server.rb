docker_installation 'default'

docker_service_manager 'default' do
  action :start
end

cookbook_file '/home/Dockerfle' do
  source 'Dockerfile'
  mode '0777'
  action :create
end

docker_container 'ssh2factor' do
  repo 'ssh2factor'
  tag 'latest'
  port '2222:22'
  action :nothing
end

docker_image 'ssh2factor' do
  source '/home/Dockerfle'
  tag 'latest'
  action :build
  notifies :redeploy, 'docker_container[ssh2factor]'
  notifies :run_if_missing, 'docker_container[ssh2factor]', :immediately
end