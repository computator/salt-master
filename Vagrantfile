Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.provider "virtualbox" do |v|
    v.customize [ "modifyvm", :id, "--uartmode1", "file", "/tmp/%s-console.log" % File.basename(Dir.pwd) ]
  end

  config.vm.synced_folder ".", "/srv/salt"
  config.vm.synced_folder ".test_pillar", "/srv/pillar"

  config.vm.provision "salt", install_master: true
  config.vm.provision "highstate", type: "shell", keep_color: true, inline: "salt-call --local --force-color state.apply salt-master"
end