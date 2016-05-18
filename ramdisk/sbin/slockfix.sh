#!/system/bin/sh

# Screen Lock Fix for ASUS Zenfone 5/6
# Author: Douglas Gadêlha <douglas@gadeco.com.br>
# Thanks-To: vigneshvikky <http://forum.xda-developers.com/member.php?u=6733361>
# Version: 20160504
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

if [ -f "/data/dgadelha/slockfix" ]; then
	ENABLED=`cat "/data/dgadelha/slockfix"`
	
	if [ "$ENABLED" == "1" ]; then
		log -p i -t slockfix "Screen Lock Fix is Enabled, running..."
		log -p i -t slockfix "Sleeping for 15 seconds (0.25 minutes)"

		# Wait for 0.25 minutes to system stabilization before updating the sysfs parameters
		sleep 15
		
		# Update the kernel sysfs parameter
		log -p i -t slockfix "Awake after 0.25 minutes, updating sysfs parameters"
		echo "0" > /sys/kernel/hall_sensor_kobject/hall_sensor/activity
		
		log -p i -t slockfix "Exiting"
		exit
	else
		log -p i -t slockfix "Screen Lock Fix is DISABLED"
		log -p i -t slockfix "To enable Screen Lock Fix please run the following command:"
		log -p i -t slockfix "echo \"1\" > /data/dgadelha/slockfix"
		log -p i -t slockfix "Exiting"
		exit
	fi
else
	log -p i -t slockfix "/data/dgadelha/slockfix was not found, exiting"
	exit
fi
