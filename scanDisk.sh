#!/bin/bash
#
# Useful for Centos/RHEL/OEL7 nodes if adding or increasing capacity of a physical hard disk
# Run scanDisk.sh and then verify new size of physical disk via "fdisk -l /dev/sd[0-9]"
#
for n in `ls /sys/class/scsi_host/`;do
        echo "- - -" > /sys/class/scsi_host/$n/scan
done
for i in `ls /sys/class/scsi_device`; do
        echo 1 > /sys/class/scsi_device/$i/device/rescan
done
