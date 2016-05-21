found=0

for rfkill in /sys/class/rfkill/rfkill[0-9]
do
	type=`cat $rfkill/type`
	if [ $type == "bluetooth" ]; then
		found=1
		chown bluetooth:net_bt_stack $rfkill/type
		chmod 0666 $rfkill/state
		chown bluetooth:net_bt_stack $rfkill/state
	fi
done

if [ $found == 0 ]; then
	chown bluetooth:net_bt_stack /sys/class/rfkill/rfkill0/type
	chmod 0666 /sys/class/rfkill/rfkill0/type/state
	chown bluetooth:net_bt_stack /sys/class/rfkill/rfkill0/type/state
fi

exit 0
