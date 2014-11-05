#!/usr/bin/env bash

yum update -y
yum install -y wget tar bzip2 unzip

if [ ! -f "/var/docker_setup" ]; then
  #yum -y update
  yum install -y docker-io
  service docker start
  chkconfig docker on

  touch /var/docker_setup
fi


#cp /vagrant/Centos-Source.repo /etc/yum.repos.d/
#yum -y install yum-utils rpm-build
#yum-builddep pam
#yumdownloader --source pam
# rpmbuild --rebuild  --define 'WITH_AUDIT 0' --define 'dist +noaudit' pam*.src.rpm
# rpm -Uvh --oldpackage ~/rpmbuild/RPMS/*/pam*+noaudit*.rpm
