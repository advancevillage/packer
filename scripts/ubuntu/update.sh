#!/bin/sh -eux

ubuntu_version="`lsb_release -r | awk '{print $2}'`";
ubuntu_major_version="`echo $ubuntu_version | awk -F. '{print $1}'`";
apt_source_url=mirrors.aliyun.com

# Disable release-upgrades
sed -i.bak 's/^Prompt=.*$/Prompt=never/' /etc/update-manager/release-upgrades;

# Update the package list
(
cat << EOF
deb http://$apt_source_url/ubuntu/ xenial main restricted universe multiverse
deb-src http://$apt_source_url/ubuntu/ xenial main restricted universe multiverse

deb http://$apt_source_url/ubuntu/ xenial-updates main restricted universe multiverse
deb-src http://$apt_source_url/ubuntu/ xenial-updates main restricted universe multiverse

deb http://$apt_source_url/ubuntu/ xenial-backports main restricted universe multiverse
deb-src http://$apt_source_url/ubuntu/ xenial-backports main restricted universe multiverse
 
deb http://$apt_source_url/ubuntu xenial-security main restricted universe multiverse
deb-src http://$apt_source_url/ubuntu xenial-security main restricted universe multiverse

EOF
) > /etc/apt/sources.list

apt-get -y update;

# update package index on boot
cat <<EOF >/etc/init/refresh-apt.conf;
description "update package index"
start on networking
task
exec /usr/bin/apt-get update
EOF

# Disable periodic activities of apt
cat <<EOF >/etc/apt/apt.conf.d/10disable-periodic;
APT::Periodic::Enable "0";
EOF

# Upgrade all installed packages incl. kernel and kernel headers
apt-get -y dist-upgrade;
reboot;
sleep 60;
