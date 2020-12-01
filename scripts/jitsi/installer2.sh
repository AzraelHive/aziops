#!/bin/bash
##
## Jitsi Server Provisioning (Bionic64)
## Copyright © 2020 AzraelHive
## Build 12012020_
##

## Add to Repository
sudo wget https://prosody.im/files/prosody-debian-packages.key -O- | sudo apt-key add - &&
sudo wget -qO - https://download.jitsi.org/jitsi-key.gpg.key | sudo apt-key add -
sudo sh -c "echo 'deb https://download.jitsi.org stable/' > /etc/apt/sources.list.d/jitsi-stable.list"

## Install Base Components for Jitsi
sudo apt update
sudo apt-cache policy libssl1.0-dev
sudo apt install -y gcc git unzip curl lua5.2 liblua5.2  luarocks libssl1.0-dev
sudo luarocks install basexx
sudo luarocks install luacrypto
sudo luarocks install net-url 

## Install JWT for Jitsi
sudo mkdir src
sudo cd src
sudo luarocks download lua-cjson 
sudo luarocks unpack lua-cjson-2.1.0.6-1.src.rock
sudo cd lua-cjson-2.1.0.6-1/lua-cjson &&
sudo sed -i 's/lua_objlen/lua_rawlen/g' lua_cjson.c &&
sudo sed -i 's|$(PREFIX)/include|/usr/include/lua5.2|g' Makefile &&
sudo luarocks make &&
sudo luarocks install luajwtjitsi 

## Install Prosody
sudo apt install -y prosody
sudo chown prosody:prosody /etc/prosody/certs/*
sudo chmod 644 /etc/prosody/certs/*
sudo cd
sudo cp /etc/prosody/certs/localhost.key /etc/ssl

## Install Jitsi Meet
sudo apt install -y nginx jitsi-meet jitsi-meet-tokens

## Provision SSL
sudo bash /usr/share/jitsi-meet/scripts/install-letsencrypt-cert.sh
