#!/bin/bash

if [ -z "$1" ]
  then
    echo "No argument supplied, usage: ./unpack_img_super.sh superimagefile.img"
    exit
fi
simg2img $1 temp-super-temp.img
lpunpack temp-super-temp.img
fallocate -l 1G system.img
resize2fs system.img 1G
mkdir -p mnt/system
sudo mount -t ext4 -o loop system.img mnt/system
fallocate -l 512M product.img
resize2fs product.img 512M
mkdir -p mnt/product
sudo mount -t ext4 -o loop product.img mnt/product
fallocate -l 512M vendor.img
resize2fs vendor.img 512M
mkdir -p mnt/vendor
sudo mount -t ext4 -o loop vendor.img mnt/vendor
