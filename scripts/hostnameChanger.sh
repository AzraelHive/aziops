#!/bin/bash
##
## hostnameChanger.sh (Bionic64)
## By James Roi Dela Cruz
## Build 12012020_0710
##

## Initialize Variable
serverHostname=$1

## Change Hostname
sudo hostnamectl set-hostname ${serverHostname}
sudo apt update
sudo apt install apt-transport-https
sudo sed -i "s/127.0.0.1\tlocalhost/127.0.0.1\tlocalhost\t${serverHostname}/" /etc/hosts

## Restart Machine
sudo reboot
