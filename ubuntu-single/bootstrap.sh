#!/bin/bash

apt-get update
apt-get install -y bridge-utils nscd

#Docker installation
if [ ! -f "/var/docker_setup" ]; then
  echo "Install docker"
  curl -sL https://get.docker.io/ | sh

  docker pull ubuntu
  
  #echo "Install nsenter"
  #docker run -v /usr/local/bin:/target jpetazzo/nsenter
  
  touch /var/docker_setup
fi

