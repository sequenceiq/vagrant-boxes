#!/bin/bash

apt-get update

#https://github.com/kschaper/wallter/issues/1
apt-get install -y language-pack-en
locale-gen en_US.UTF-8

#http://thegreyblog.blogspot.hu/2012/02/fixing-mac-os-x-lions-ssh-utf-8-issues.html

if [ ! -f "/var/fix_hosts" ]; then
  cat /vagrant/hosts > /etc/hosts
  touch /var/fix_hosts
fi
