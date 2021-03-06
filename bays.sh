#!/bin/sh
echo "BAY: DEVICE"
for bay in `find /sys/devices -path '/sys/devices/*/*/*/host*/port-*/expander-*/port-*/end_device-*/sas_device/end_device-*/bay_identifier'`; do
	bay_number=`cat $bay`
	bay_device=`echo $bay | grep -o '/end_device-[0-9:]*/' | head -n1 | cut -d/ -f2 | grep -o '[0-9:]*'`
	echo "$bay_number: $bay_device"
done;