#!/bin/bash

if [ -d "./mnt/system" ]; then
    sudo umount mnt/system
fi
e2fsck -yf system.img
resize2fs -M system.img
e2fsck -yf system.img
sudo umount mnt/vendor
e2fsck -yf vendor.img
resize2fs -M vendor.img
e2fsck -yf vendor.img
system=`stat -c '%n %s' system.img`
system=${system#* }
vendor=`stat -c '%n %s' vendor.img`
vendor=${vendor#* }
suma=$((system + vendor))
ext4=`stat -c '%n %s' temp-super-temp.img`
ext4=${ext4#* }
lpmake --metadata-size 65536 --super-name super --metadata-slots 1 --device super:$ext4   --group main:$suma --partition system:readonly:$system:main --image system=./system.img --partition vendor:readonly:$vendor:main --image vendor=./vendor.img --sparse --output ./super.new.img
rm -rf mnt
rm -f system.img vendor.img temp-super-temp.img
