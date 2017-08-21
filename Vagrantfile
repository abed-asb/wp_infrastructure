Vagrant.configure("2") do |config|
  config.vm.box = "debian/jessie64"
  config.vm.host_name = 'development'
  config.vm.network "forwarded_port", guest: 8080, host: 8999
  config.vm.network "forwarded_port", guest: 9000, host: 9000
  config.vm.network "private_network", ip: "192.168.50.11"
  config.vm.synced_folder "../", "/var/www", type: "nfs"
  config.vm.provision :shell, :path => "provision/setup.sh"
  # Disable the default /vagrant synced folder
  config.vm.synced_folder ".", "/vagrant", disabled: true
  # Mount /project directory to /var/www/project using default synced folders
  # config.vm.synced_folder "./", "/var/www", {:mount_options => ['dmode=777','fmode=777']}
end