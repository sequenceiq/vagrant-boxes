#!/bin/bash

yum install -y wget tar bzip2 unzip


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
    #workaround about missing shasum
    ln -s /usr/bin/sha256sum /usr/bin/shasum

    curl https://raw.githubusercontent.com/sequenceiq/cloudbreak-deployer/master/install | sh

    touch /var/install_cbd
  fi
}


install_cloudbreak() {
  mkdir /root/cbd_test
  cd /root/cbd_test
  cat > Profile << ENDOFPROFILE
  export PRIVATE_IP=$(docker run alpine sh -c 'ip ro | grep default | cut -d" " -f 3')
  export PUBLIC_IP=192.168.44.10
  export CLOUDBREAK_SMTP_SENDER_USERNAME=xxx
  export CLOUDBREAK_SMTP_SENDER_PASSWORD=xxx
  export CLOUDBREAK_SMTP_SENDER_HOST=email-smtp.us-east-1.amazonaws.com
  export CLOUDBREAK_SMTP_SENDER_PORT=25
  export CLOUDBREAK_SMTP_SENDER_FROM=dummy@example.com
  export UAA_CLOUDBREAK_SECRET=b6bffc749b
  export UAA_PERISCOPE_SECRET=b6bffc749b
  export UAA_ULUWATU_SECRET=b6bffc749b
  export UAA_SULTANS_SECRET=b6bffc749b
  ENDOFPROFILE
  cbd start
}


main() {
    permissive_iptables
    epel_repo
    install_docker
    install_cbd
    install_cloudbreak
}

main
