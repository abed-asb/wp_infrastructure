#! /usr/bin/env bash

# Variables
APPENV=local
DBHOST=localhost
DBNAME=mydatabase
DBUSER=root
DBPASSWD=123456
PROJECTFOLDER=wordpress
DBUSER_ABD=abood
DBPASSWD_ABD=123456

echo -e "\n Provisioning virtual machine...."
echo -e "\n Updating packages list \n"
apt-get -qq update

echo -e "\n Install base packages \n"
apt-get -y install vim curl build-essential python-software-properties git

# PHP
echo -e "\n Installing PHP repository \n"
apt-get install apt-transport-https lsb-release ca-certificates -y
wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list
apt-get update
apt-get install php7.1 hp7.1-common php7.1-dev php7.1-cli php7.1-fpm php7.1-mysql  libapache2-mod-php7.1 -y 
#end PHP

echo -e "\n Updating packages list \n"
apt-get -qq update

# MySQL 
echo -e "\n Preparing MySQL \n"
apt-get install debconf-utils -y > /dev/null
debconf-set-selections <<< "mysql-server mysql-server/root_password password 123456"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password 123456"

echo -e "\n Installing MySQL \n"
apt-get update
apt-get install -y mysql-server

#MySQL Setting User and DB
echo -e "\n Setting up our MySQL user and db \n"
mysql -uroot -p$DBPASSWD -e "CREATE DATABASE IF NOT EXISTS $DBNAME"
mysql -uroot -p$DBPASSWD -e "grant all privileges on $DBNAME.* to '$DBUSER'@'localhost' identified by '$DBPASSWD'"
mysql -uroot -p$DBPASSWD -e "CREATE USER '$DBUSER_ABD'@'localhost' IDENTIFIED BY '$DBPASSWD_ABD';"
mysql -uroot -p$DBPASSWD -e "GRANT ALL PRIVILEGES ON * . * TO '$DBUSER_ABD'@'localhost';"
mysql -uroot -p$DBPASSWD -e "FLUSH PRIVILEGES;"

# Git
echo "\n Installing Git \n"
apt-get install git 

# Nginx
#echo "\n Installing Nginx \n"
#apt-get install nginx -y
#echo "\n Starting Nginx \n"
#sudo systemctl start nginx
#echo "\n Nginx Status \n"
#sudo systemctl status nginx

# apache 2.5 
echo "\n Installing apache2 \n"
sudo apt-get install  apache2 -y
echo "\n Starting apache2 \n"
sudo service apache2 start
echo "\n apache2 Status \n"
sudo service apache2 status

# setup hosts file
VHOST=$(cat <<EOF
<VirtualHost *:80>
    DocumentRoot "/var/www/${PROJECTFOLDER}"
    <Directory "/var/www/${PROJECTFOLDER}">
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
EOF
)
echo "${VHOST}" > /etc/apache2/sites-available/000-default.conf

# enable mod_rewrite
sudo a2enmod rewrite


# redis
echo -e "\n Install redis \n"
sudo apt-get install -y --force-yes redis-server

# rabbitmq-server
echo -e "\n Install rabbitmq-server \n"
sudo apt-get install -y --force-yes rabbitmq-server

# composer
echo -e "\n Installing Composer for PHP package management \n"
curl --silent https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# NodeJS
echo -e "\n Installing NodeJS \n"
apt-get -y install nodejs 

# NPM
echo -e "\n Installing NPM \n"
apt-get -y install npm

# GULP / BOWER
echo -e "\n Installing javascript components \n"
npm install -g gulp bower

echo -e "\n Finished provisioning \n"
