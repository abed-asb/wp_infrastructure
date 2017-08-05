Vagrant.configure("2") do |config|
  config.vm.box = "debian/jessie64"
  config.vm.host_name = 'abd.local'
  config.vm.network "forwarded_port", guest: 8080, host: 8999
  config.vm.network "forwarded_port", guest: 9000, host: 9000
  config.vm.network "private_network", ip: "192.168.50.11"
  config.vm.synced_folder "../", "/var/www/html", type: "nfs"
  config.vm.provision :shell, :path => "provision/setup.sh"
end