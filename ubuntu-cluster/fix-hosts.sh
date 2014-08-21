#!/bin/bash

if [ ! -f "/var/fix_hosts" ]; then
  cat /vagrant/hosts > /etc/hosts
  touch /var/fix_hosts
fi
