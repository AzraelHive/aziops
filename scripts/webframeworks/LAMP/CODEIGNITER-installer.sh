#!/bin/bash
##
## LAMP Stack Installation Script
## Copyright © 2020 AzraelHive
##

## Modify Repository
sudo add-apt-repository ppa:ondrej/php

## User Home Directory
sudo cd ~

## Update and Upgrade Distro
sudo apt update
sudo apt upgrade -y

## Install Git, Curl and Unzip
sudo apt install unzip curl git -y

## Install & Setup Web Server 
sudo apt install apache2 -y
sudo cd /etc/apache2/sites-available
sudo rm 000-default.conf
sudo wget https://raw.githubusercontent.com/AzraelHive/aziops/main/scripts/webframeworks/lamp/codeigniter/etc/apache2/sites-available/000-default.conf -O /etc/apache2/sites-available/000-default.conf
sudo a2enmod rewrite
sudo service apache2 restart

## Install & Setup MySQL Database
sudo apt install mysql-server mysql-client -y 
sudo mysql -u root -p <<myQuery
  CREATE USER 'user'@'%' identified by 'password';
  GRANT ALL PRIVILEGES ON *.* TO 'user'@'%';
  DROP USER ''@'localhost'
  DROP USER ''@'$(hostname)'
  DROP DATABASE test
  FLUSH PRIVILEGES;
myQuery

## Install & Setup PHP
sudo apt install php7.2 -y
sudo apt install php7.2-bcmath php7.2-curl php7.2-dev php7.2-gd php7.2-intl php7.2-mbstring php7.2-xml php7.2-zip php7.2-mysql php-cli libapache2-mod-php php7.2-dev -y

## Install & Setup Composer
sudo curl -sS https://getcomposer.org/installer -o composer-setup.php
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
sudo rm composer-setup.php

## Downlaod & Configure Codeigniter
sudo wget -O ci3.zip https://api.github.com/repos/bcit-ci/CodeIgniter/zipball/3.1.11
sudo unzip ci3.zip
sudo mv bcit-ci-CodeIgniter-* /var/www/html/codeigniter
sudo chmod -R 775 /var/www/html/codeigniter
sudo chown -R www-data:www-data /var/www/html/codeigniter
