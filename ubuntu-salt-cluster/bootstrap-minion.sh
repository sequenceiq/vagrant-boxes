#!/bin/bash

#Salt setup
if [ ! -f "/var/salt_setup" ]; then
  echo "Salt setup"

  #curl -sL https://bootstrap.saltstack.com | sh
  wget -O install_salt.sh https://bootstrap.saltstack.com
  sh install_salt.sh

  touch /var/salt_setup
fi
