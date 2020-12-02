#!/bin/bash
##
## OpenProject Installation Script (Bionic64)
## Copyright © 2020 AzraelHive
##

## Add the OpenProject Repository
sudo wget -qO- https://dl.packager.io/srv/opf/openproject/key | sudo apt-key add -
sudo wget -O /etc/apt/sources.list.d/openproject.list https://dl.packager.io/srv/opf/openproject/stable/11/installer/ubuntu/18.04.repo
sudo apt update
sudo apt upgrade -y

## Install OpenProject
sudo apt install openproject -y

## Configure OpenProject
sudo openproject configure
