Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.provider "virtualbox" do |v|
    v.name = nil
    v.customize [ "modifyvm", :id, "--uartmode1", "file", "/tmp/%s-console.log" % File.basename(Dir.pwd) ]
  end

  config.vm.synced_folder ".", "/srv/salt"
  config.vm.synced_folder ".test_pillar", "/srv/pillar"

  config.vm.provision "salt", install_master: true
  config.vm.provision "shell", inline: "salt-call --local state.apply salt-master"
end