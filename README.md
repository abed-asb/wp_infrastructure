# WP Infrastructure #

WP Infrastructure that can be used for all WP services and environments.

### Perquisites ###

* Install Vagrant from https://www.vagrantup.com/downloads.html
* Install VirtualBox from https://www.virtualbox.org/wiki/Downloads

### What is this repository for? ###

* Create Vagrant using shell script

### Development Environment (Setup) ###

This step will generate one vagrant:

```sh
$ git@github.com:aboodasbahi/wp_infrastructure.git
$ cd wp_infrastructure 
$ vagrant up
```

### Development Environment (Update)  ###

##### Running Development Environment: #####
On running Vagrant
```sh
$ vagrant provision
```

On turned off Vagrant
```sh
$ vagrant up --provision
```

### Development Environment (Running)  ###

##### Running Development Environment: #####
```sh
$ vagrant up
```

##### Login inside the virtual machine: #####
```sh
$ vagrant ssh
```
##### Connect DB Using Workbench by ssh: #####

- Download MySQL Workbench from https://dev.mysql.com/downloads/workbench/
- Within your project directory type vagrant ssh-config in the command line. This will give you a few things you'll need.

	-User: (most likely vagrant)
	-IdentityFile (the path to the private key that MySQL workbench will need)

- Open up MySQL Workbench and create a new connection

	* Connection Method: Standard TCIP/IP over SSH
	* SSH Hostname: 127.0.0.1:2222
	* SSH Username: vagrant (from your ssh-config above)
	* SSH Password: leave this alone
	* SSH Key File: Use the IdentityFile path from above.
	* MySQL Hostname: 127.0.0.1
	* MySQL Port: 3306
	* Username: whatever username you usually use
	* Password: the password for the db
	* After that, make sure your vagrant box is up and running, then you should be able to simply connect to the DB!
