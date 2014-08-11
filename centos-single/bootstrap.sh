#!/bin/bash

yum install -y wget tar bzip2 unzip

if [ ! -f "/var/epel_repo" ]; then
  echo "Execute repo config"
  wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
  wget http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
  rpm -Uvh remi-release-6*.rpm epel-release-6*.rpm

  touch /var/epel_repo
fi



if [ ! -f "/var/docker_setup" ]; then
  echo "Install docker"
  #yum -y update
  yum install -y docker-io
  service docker start
  chkconfig docker on

  echo "Install nsenter"
  docker run -v /usr/local/bin:/target jpetazzo/nsenter

  touch /var/docker_setup
fi

echo "Enable all incoming traffic"
iptables -I INPUT -j ACCEPT
