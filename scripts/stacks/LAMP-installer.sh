#!/bin/bash
##
## LAMP Stack Installation Script
## Copyright © 2020 AzraelHive
##

## User Home Directory
cd ~

## Update and Upgrade Distro
sudo apt update
sudo apt upgrade -y

## Install & Setup Web Server 
sudo apt install apache2 -y
cd /etc/apache2/sites-available
rm 000-default.conf
sudo wget https://raw.githubusercontent.com/AzraelHive/aziops/main/scripts/stacks/etc/apache2/sites-available/000-default.conf -O /etc/apache2/sites-available/000-default.conf
sudo a2enmod rewrite

## Install & Setup MySQL Database
sudo apt install mysql-server mysql-client -y 
mysql -u root -p <<myQuery
  CREATE USER 'user'@'%' identified by 'password';
  GRANT ALL PRIVILEGES ON *.* TO 'user'@'%';
  DROP USER ''@'localhost'
  DROP USER ''@'$(hostname)'
  DROP DATABASE test
  FLUSH PRIVILEGES;
myQuery

## Install & Setup PHP
sudo apt install php7.2 -y
sudo apt install php7.2-curl php7.2-dev php7.2-gd php7.2-intl php7.2-mbstring php7.2-xml php7.2-zip php7.2-mysql php-cli libapache2-mod-php -y

## Create PHP Information File
echo "<?php phpinfo();?>" >> /var/www/html/info.php

## Install & Setup Composer
sudo curl -sS https://getcomposer.org/installer -o composer-setup.php
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
rm composer-setup.php