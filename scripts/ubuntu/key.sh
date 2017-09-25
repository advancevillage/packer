#!/bin/sh -eux

# set a default HOME_DIR environment variable if not set
user=richard
HOME_DIR="${HOME_DIR:-/home/$user}";

pubkey_url="https://github.com/advancevillage/packer/blob/master/id_rsa.pub";
mkdir -p $HOME_DIR/.ssh;
if command -v wget >/dev/null 2>&1; then
    wget --no-check-certificate "$pubkey_url" -O $HOME_DIR/.ssh/authorized_keys;
elif command -v curl >/dev/null 2>&1; then
    curl --insecure --location "$pubkey_url" > $HOME_DIR/.ssh/authorized_keys;
elif command -v fetch >/dev/null 2>&1; then
    fetch -am -o $HOME_DIR/.ssh/authorized_keys "$pubkey_url";
else
    echo "Cannot download $user public key";
    exit 1;
fi
chown -R $user $HOME_DIR/.ssh;