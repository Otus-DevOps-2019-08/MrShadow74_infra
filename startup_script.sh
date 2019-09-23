#!/bin/bash

#update repo & install ruby
sudo apt update
sudo apt install -y ruby-full ruby-bundler build-essential

#check result
sudo ruby -v
sudo bundler -v

#install & start mongodb
wget -qO - https://www.mongodb.org/static/pgp/server-3.2.asc | sudo apt-key add -
sudo bash -c 'echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.2.list'
sudo apt install -y mongodb-org
sudo systemctl start mongod && systemctl enable mongod
#check result
mongo --version
systemctl status mongod.service

#deploy application
git clone -b monolith https://github.com/express42/reddit.git /usr/puma
cd /usr/puma && bundle install
puma -d
#check result
ps xa | grep puma