#!/bin/bash

apt-get update
apt-get install -y bridge-utils

#Docker installation
if [ ! -f "/var/docker_setup" ]; then
  echo "Install docker"
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
  sh -c "echo deb https://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list"
  apt-get update
  apt-get install -y lxc-docker

  docker pull ubuntu
  
  #echo "Install nsenter"
  #docker run -v /usr/local/bin:/target jpetazzo/nsenter
  
  touch /var/docker_setup
fi

