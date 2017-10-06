#!/bin/sh -eux

sed -i -e '/Defaults\s\+env_reset/a Defaults\texempt_group=sudo' /etc/sudoers;

# Set up password-less sudo for the vagrant user
echo 'vagrant ALL=(ALL) NOPASSWD:ALL' >/etc/sudoers.d/vagrant;
chmod 440 /etc/sudoers.d/vagrant;

webuser=cuger
webpasswd=richardkelly
groupadd $webuser
useradd -c $webuser -d /home/$webuser -g $webuser -s /bin/bash  $webuser
echo $webuser:$webpasswd | chpasswd
echo "$webuser ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$webuser
chmod 440 /etc/sudoers.d/$webuser

