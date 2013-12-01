#!/bin/bash
set -e
sudo yum install yum-utils createrepo -y

sudo mkdir -p /var/yum/el6/x86_64
cp /vagrant/pkg/* /var/yum/el6/x86_64/.
/usr/bin/createrepo --database /var/yum/el6/x86_64

sudo sh -c 'echo "[fsbox]" >> /etc/yum.repos.d/fsbox.repo'
sudo sh -c 'echo "name=fsbox" >> /etc/yum.repos.d/fsbox.repo'
sudo sh -c 'echo "enabled=1" >> /etc/yum.repos.d/fsbox.repo'
sudo sh -c 'echo "gpgcheck=0" >> /etc/yum.repos.d/fsbox.repo'
sudo sh -c 'echo "baseurl=file:///var/yum/el6/x86_64" >>/etc/yum.repos.d/fsbox.repo'

sudo yum clean all
sudo yum update -y

