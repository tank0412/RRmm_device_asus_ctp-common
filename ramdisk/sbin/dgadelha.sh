#!/system/bin/sh

# Custom Features Setup Script for ASUS Zenfone 5/6
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

if [ ! -d "/data/dgadelha" ]; then
	log -p i -t dgadelha "Creating /data/dgadelha"
	mkdir /data/dgadelha
	chown system:system /data/dgadelha
	chmod 0775 /data/dgadelha
fi

# dnfix, ENABLED by default
if [ ! -f "/data/dgadelha/dnfix" ]; then
	log -p i -t dgadelha "Generating /data/dgadelha/dnfix"
	touch /data/dgadelha/dnfix
	chown system:system /data/dgadelha/dnfix
	chmod 0664 /data/dgadelha/dnfix
	echo "1" > /data/dgadelha/dnfix
fi

# modemrestart, DISABLED by default
if [ ! -f "/data/dgadelha/modemrestart" ]; then
	log -p i -t dgadelha "Generating /data/dgadelha/modemrestart"
	touch /data/dgadelha/modemrestart
	chown system:system /data/dgadelha/modemrestart
	chmod 0664 /data/dgadelha/modemrestart
	echo "0" > /data/dgadelha/modemrestart
fi

# slockfix, DISABLED by default
if [ ! -f "/data/dgadelha/slockfix" ]; then
	log -p i -t dgadelha "Generating /data/dgadelha/slockfix"
	touch /data/dgadelha/slockfix
	chown system:system /data/dgadelha/slockfix
	chmod 0664 /data/dgadelha/slockfix
	echo "0" > /data/dgadelha/slockfix
fi
