#!/bin/bash
#!/bin/rm -f
##
## MongoDB 4.4 Installation Script (Focal64)
## Copyright © 2020 AzraelHive
##

## Add the MongoDB Repository
sudo curl -fsSL https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
sudo echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
sudo apt update
sudo apt upgrade -y

## Install MongoDB
sudo apt install mongodb-org

## Enable Remote Access
sed -i 's/bindIp: 127.0.0.1/bindIp: 0.0.0.0/g' /etc/mongod.conf
sed -i '/\#security:/asecurity:\n  authorization: enabled' /etc/mongod.conf

## Finalize Installation
rm -rf mongodb_focal64.sh
sudo systemctl start mongod
sudo systemctl enable mongod
