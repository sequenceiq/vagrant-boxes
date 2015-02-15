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

#touch /var/halite_setup
#Halite setup
if [ ! -f "/var/halite_setup" ]; then
  echo "Halite setup"

  #http://docs.saltstack.com/en/latest/topics/tutorials/halite.html
  apt-get install -y gcc python-pip python-dev libevent-dev

  pip install -U halite
  pip install CherryPy
  pip install gevent
  pip install pyopenssl

  salt-call tls.create_self_signed_cert tls

  cat /vagrant/halite.yml >> /etc/salt/master
  service salt-master restart

  touch /var/halite_setup
fi
