#!/system/bin/sh

# Timed Modem Restart for ASUS Zenfone 5/6
# Author: Douglas Gadêlha <douglas@gadeco.com.br>
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

if [ -f "/data/dgadelha/modemrestart" ]; then
	ENABLED=`cat "/data/dgadelha/modemrestart"`
	
	if [ "$ENABLED" == "1" ]; then
		log -p i -t modemrestart "Modem Restart is Enabled, running..."
		log -p i -t modemrestart "Sleeping for 300 seconds (5 minutes)"

		# RIL starts to show some instabilities 5 minutes after booting
		sleep 300

		# Restart the RIL daemons after the 5 minutes
		log -p i -t modemrestart "Awake after 5 minutes, restarting RIL daemons"

		stop ril-daemon
		stop ril-daemon2

		start ril-daemon
		start ril-daemon2

		log -p i -t modemrestart "Sleeping for 900 seconds (15 minutes)"

		# RIL shows some more instabilities after 15 minutes
		sleep 900

		# Restart the RIL daemons after the 15 minutes
		log -p i -t modemrestart "Awake after 15 minutes, restarting RIL daemons (x2)"

		stop ril-daemon
		stop ril-daemon2

		start ril-daemon
		start ril-daemon2

		# No more RIL instabilities were detected at the tests, exit
		log -p i -t modemrestart "No more instabilities to fix, exiting"
		exit
	else
		log -p i -t modemrestart "Modem Restart is NOT enabled"
		log -p i -t modemrestart "To enable Modem Restart please run the following command:"
		log -p i -t modemrestart "echo \"1\" > /data/dgadelha/modemrestart"
		log -p i -t modemrestart "Exiting"
		exit
	fi
else
	log -p i -t modemrestart "/data/dgadelha/modemrestart was not found, exiting"
	exit
fi
