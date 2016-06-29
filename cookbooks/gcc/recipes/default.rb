bash "echo gcc"

node[:gcc][:versions].each do |v|
  package "gcc-#{v}"

  bash "add gcc-#{v} to alternatives" do
    code <<-OET
      COMMAND="update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-#{v} 60"
      SLAVES_BINS=($(dpkg-query -L gcc-#{v} | grep -v /usr/bin/gcc | grep /usr/bin/))
      for element in "${SLAVES_BINS[@]}"
      do
        BIN=${element//"/usr/bin/"/}
        COMMAND="$COMMAND --slave /usr/bin/${BIN//-#{v}} ${BIN//-#{v}} $element"
      done
      if [ -z $(update-alternatives --list gcc | grep #{v})]
      then
        eval $COMMAND
      fi
    OET
  end
end


cookbook_file '/usr/local/bin/switch-gcc' do
  source 'switch-gcc.sh'
  mode '0755'
  action :create
end


