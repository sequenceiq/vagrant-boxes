#!/bin/bash

#Salt setup
if [ ! -f "/var/salt_setup" ]; then
  echo "Salt setup"

  #curl -sL https://bootstrap.saltstack.com | sh
  wget -O install_salt.sh https://bootstrap.saltstack.com
  sh install_salt.sh -M -N

  echo "auto_accept: True" >> /etc/salt/master
  service salt-master restart

  touch /var/salt_setup
fi
