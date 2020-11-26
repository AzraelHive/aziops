#!/bin/bash
##
## LAMP Stack (Laravel) Installation Script
## Copyright © 2020 AzraelHive
##

## User Home Directory
sudo cd ~

## Update and Upgrade Distro
sudo apt update
sudo apt upgrade -y

## Install & Setup Web Server 
sudo apt install apache2 -y
sudo cd /etc/apache2/sites-available
sudo rm 000-default.conf
sudo wget https://raw.githubusercontent.com/AzraelHive/aziops/main/scripts/stacks/webframeworks/LAMP/laravel/etc/apache2/sites-available/000-default.conf -O /etc/apache2/sites-available/000-default.conf
sudo a2enmod rewrite

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
sudo apt install php7.2-bcmath php7.2-curl php7.2-dev php7.2-gd php7.2-intl php7.2-mbstring php7.2-xml php7.2-zip php7.2-mysql php-cli libapache2-mod-php php7.2-dev libmcrypt-dev php-pear -y

# Instal mcrypt Module
sudo pecl channel-update pecl.php.net
sudo pecl install mcrypt-1.0.1

## Add mcrypt Module to php.ini
sudo wget -O /etc/php/7.2/apache2/php.ini https://raw.githubusercontent.com/AzraelHive/aziops/main/scripts/stacks/webframeworks/LAMP/laravel/php/7.2/apache2/php.ini

## Create PHP Information File
sudo echo "<?php phpinfo();?>" >> /var/www/html/info.php

## Install & Setup Composer
sudo curl -sS https://getcomposer.org/installer -o composer-setup.php
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
sudo rm composer-setup.php

## Download & Configure Laravel
sudo cd /var/www/html
sudo git clone -b 7.x https://github.com/laravel/laravel.git
sudo cd laravel
sudo composer install
sudo chown -R www-data:www-data /var/www/html/laravel
sudo chmod -R 775 /var/www/html/laravel
sudo chmod -R 777 /var/www/html/laravel/storage
sudo mv .env.example .env
sudo php artisan key:generate
sudo service apache2 restart