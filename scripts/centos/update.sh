#!/bin/sh -eux

source_url=mirrors.aliyun.com

(
cat << EOF
[base]
name=CentOS-\$releasever - Base - $source_url
baseurl=http://$source_url/centos/\$releasever/os/\$basearch/
gpgcheck=1
gpgkey=http://$source_url/centos/RPM-GPG-KEY-CentOS-7

[updates]
name=CentOS-\$releasever - Updates - $source_url
baseurl=http://$source_url/centos/\$releasever/updates/\$basearch/
gpgcheck=1
gpgkey=http://$source_url/centos/RPM-GPG-KEY-CentOS-7

[extras]
name=CentOS-\$releasever - Extras - $source_url
baseurl=http://$source_url/centos/\$releasever/extras/\$basearch/
gpgcheck=1
gpgkey=http://$source_url/centos/RPM-GPG-KEY-CentOS-7

[centosplus]
name=CentOS-\$releasever - Plus - $source_url
baseurl=http://$source_url/centos/\$releasever/centosplus/\$basearch/
gpgcheck=1
enabled=0
gpgkey=http://$source_url/centos/RPM-GPG-KEY-CentOS-7

EOF
) > /etc/yum.repos.d/CentOS-Base.repo

yum -y update;
yum -y install bzip2;
yum -y install gcc make kernel-devel kernel-headers;
reboot;
sleep 60;
