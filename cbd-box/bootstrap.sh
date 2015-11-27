#!/bin/bash

generic_tools() {
  yum -y install wget curl git unzip
}


permissive_iptables() {
  # need to install iptables-services, othervise the 'iptables save' command will not be available
  yum -y install iptables-services net-tools

  iptables --flush INPUT
  iptables --flush FORWARD
  service iptables save
}

disable_selinux() {
  setenforce 0
  sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
}

install_docker() {
  cat >/etc/yum.repos.d/docker.repo <<-EOF
[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/centos/$releasever/
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg
EOF
  yum install -y docker-engine
  systemctl start docker
  systemctl enable docker
  usermod -aG docker vagrant
}



main() {
  generic_tools
  permissive_iptables
  disable_selinux
  install_docker
}

[[ "$0" == "$BASH_SOURCE" ]] && main "$@"
