#!/system/bin/sh
# software configuration related boot actions
# shellscript as this is the only way selinux will allow this to proceed
/system/bin/gpsd -c /system/etc/gpsconfig.xml
