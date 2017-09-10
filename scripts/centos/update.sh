#!/bin/sh -eux

yum -y update;
yum -y install bzip2
yum -y install gcc make kernel-devel kernel-headers
reboot;
sleep 60;
