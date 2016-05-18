#!/system/bin/sh

# Device Name Fix for ASUS Zenfone 5/6
# Author: Douglas Gadêlha <douglas@gadeco.com.br>
# Version: 20160517
#
# The MIT License (MIT)
#
# Copyright (c) 2016 Douglas Gadêlha. All Rights Reserved.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# NOTE: This feature is ENABLED by DEFAULT.

if [ -f "/data/dgadelha/dnfix" ]; then
	ENABLED=`cat "/data/dgadelha/dnfix"`

	if [ "$ENABLED" == "0" ]; then
		log -p i -t dnfix "Device Name Fix is DISABLED"
		log -p i -t dnfix "To enable Device Name Fix please run the following command:"
		log -p i -t dnfix "echo \"1\" > /data/dgadelha/dnfix"
		log -p i -t dnfix "Exiting"
		exit
	fi
fi

PROJECT_ID=$(cat /sys/module/intel_mid_sfi/parameters/project_id)

if [ -n "$PROJECT_ID" ]; then
	if [ "$PROJECT_ID" -ge 0 -a "$PROJECT_ID" -le 4 ]; then
		log -p i -t dnfix "Detected Device: ASUS Zenfone 5"
		setprop ro.product.device ASUS_T00F
		stop akmd_a600cg
		start akmd
	elif [ "$PROJECT_ID" -eq 5 -o "$PROJECT_ID" -eq 7 ]; then
		log -p i -t dnfix "Detected Device: ASUS Zenfone 6"
		setprop ro.product.device ASUS_T00G
		stop akmd
		start akmd_a600cg

		UPDATED=$(getprop dgadelha.dnfix.updated))

		if [ "$UPDATED" == "true" ]; then
			log -p i -t dnfix "Build Properties already updated"
		else
			log -p i -t dnfix "Build Properties are NOT updated, updating..."

			log -p i -t dnfix "Re-mounting System as Read-Write..."
			mount -o remount,rw /system

			log -p i -t dnfix "Updating build.prop..."
			sed -i 's/T00F/T00G/g' /system/build.prop
			echo "\n# dnfix\ndgadelha.dnfix.updated=true\n" >> /system/build.prop

			log -p i -t dnfix "Updating Sensors Library..."
			rm /system/lib/hw/sensors.redhookbay.so
			ln -s /system/lib/hw/a600cg.sensors.redhookbay.so /system/lib/hw/sensors.redhookbay.so

			log -p i -t dnfix "Re-inforcing permissions of modified files..."
			chmod 0644 /system/lib/hw/a500cg.sensors.redhookbay.so
			chmod 0644 /system/lib/hw/a600cg.sensors.redhookbay.so
			chmod 0644 /system/lib/hw/sensors.redhookbay.so
			chmod 0644 /system/build.prop

			log -p i -t dnfix "Re-mounting System as Read-Only..."
			mount -o remount,ro /system

			log -p i -t dnfix "Build Properties updated. You may need to reboot to apply the changes"
		fi
	else
		log -p i -t dnfix "Unknown device. Exiting"
		exit
	fi
fi
