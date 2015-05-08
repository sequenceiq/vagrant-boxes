#!/bin/bash

yum install -y wget tar bzip2 unzip ntp


permissive_iptables() {
  echo "Permissive iptabpes config"
  if [ ! -f "/var/permissive_iptables" ]; then
    iptables --flush INPUT
    iptables --flush FORWARD
    service iptables save

    touch /var/permissive_iptables
  fi

}

epel_repo() {
  echo "Execute repo config"
  if [ ! -f "/var/epel_repo" ]; then
    wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
    rpm -Uvh epel-release-6*.rpm

    touch /var/epel_repo
  fi
}

install_docker() {
  echo "Install docker"
  if [ ! -f "/var/docker_setup" ]; then
    yum install -y device-mapper
    yum install -y docker-io
    service docker start
    chkconfig docker on

    touch /var/docker_setup
  fi
}


install_cbd() {
  echo "Install cbd"
  if [ ! -f "/var/install_cbd" ]; then
    curl https://raw.githubusercontent.com/sequenceiq/cloudbreak-deployer/master/install | sh

    touch /var/install_cbd
  fi
}


setup_env() {
  mkdir -p /root/cbd_test
  cd /root/cbd_test
  cat > Profile << ENDOFPROFILE
export PUBLIC_IP=192.168.44.10
ENDOFPROFILE
}

update_cbd() {
  cd /root/cbd_test
  cbd update master
}


main() {
    permissive_iptables
    epel_repo
    install_docker
    install_cbd
    setup_env
    update_cbd

    cp -v /vagrant/cb-start.sh /root/cbd_test/
    chmod +x /root/cbd_test/cb-start.sh

    echo "Environment setup was SUCCESSFUL"
}

main
