#!/bin/sh -eux

sed -i -e '/Defaults\s\+env_reset/a Defaults\texempt_group=sudo' /etc/sudoers;
user=richard
sudofilename=00_$user

# Set up password-less sudo for the node user
echo "$user ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/$sudofilename;
chmod 440 /etc/sudoers.d/$sudofilename;