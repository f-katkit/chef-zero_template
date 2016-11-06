#!/bin/sh

# generate onetime sshpass
# SSHPASS=$(sudo ifconfig | head -1 |awk '{print $5}' |openssl sha1|awk '{print $2}'

# install utility application.
sudo apt-get update
sudo apt-get install -yq wget ruby curl vim git openssl openssh-server zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev

# enable root login
sudo sed -i -e "s/PermitRootLogin = .*/PermitRootLogin = without-password/g" /etc/ssh/sshd_config
sudo ssh-keygen -f /root/.ssh/id_rsa -t rsa -N ""
sudo cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys
sudo cat << EOT >> /root/.ssh/config
Host 127.0.0.1
  HostName 127.0.0.1
  User root
  Port 22
  IdentityFile /root/.ssh/id_rsa
  StrictHostKeyChecking no
  UserKnownHostsFile=/dev/null
EOT

sudo chmod 600 /root/.ssh/*
sudo chmod 700 /root/.ssh
sudo service ssh restart

# install chef
wget https://packages.chef.io/stable/ubuntu/12.04/chefdk_0.19.6-1_amd64.deb
sudo dpkg -i chefdk_0.19.6-1_amd64.deb
sudo chef gem install knife-zero

# add user ubuntu
sudo adduser ubuntu

# install bootstrap or chef-client -z
# knife zero bootstrap localhost -x root --node-name localhost
sudo sh -c "cd /root/chef-zero/; chef-client -z -N localhost"
