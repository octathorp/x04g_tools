#!/bin/bash

sudo umount mnt/system
e2fsck -yf system.img
resize2fs -M system.img
e2fsck -yf system.img
sudo umount mnt/product
e2fsck -yf product.img
resize2fs -M product.img
e2fsck -yf product.img
sudo umount mnt/vendor
e2fsck -yf vendor.img
resize2fs -M vendor.img
e2fsck -yf vendor.img
system=`stat -c '%n %s' system.img`
system=${system#* }
product=`stat -c '%n %s' product.img`
product=${product#* }
vendor=`stat -c '%n %s' vendor.img`
vendor=${vendor#* }
total=$((system + product + vendor))
old=`stat -c '%n %s' super.bin`
old=${old#* }
lpmake --metadata-size 65536 --super-name super --metadata-slots 1 --device super:$old --group main:$total --partition system:readonly:$system:main --image system=./system.img --partition vendor:readonly:$vendor:main --image vendor=./vendor.img --partition product:readonly:$product:main --image product=./product.img --sparse --output ./NEW_super.img
rm -rf mnt
rm -f product.img system.img vendor.img
