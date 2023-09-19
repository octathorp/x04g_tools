#!/bin/bash

if [ -z "$1" ]
  then
    echo "No argument supplied, usage: ./unpack_img_super.sh superimagefile.img"
    exit
fi
simg2img $1 temp-super-temp.img
lpunpack temp-super-temp.img
if [[ -f "product.img" ]]; then
    rm -f product.img
    rm -f system.img
else
    fallocate -l 2G system.img
    resize2fs system.img 2G
    mkdir -p mnt/system
    sudo mount -t ext4 -o loop system.img mnt/system
fi
fallocate -l 512M vendor.img
resize2fs vendor.img 512M
mkdir -p mnt/vendor
sudo mount -t ext4 -o loop vendor.img mnt/vendor
