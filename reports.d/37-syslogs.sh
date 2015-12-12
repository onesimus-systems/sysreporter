#! /bin/bash
if [ "$2" == "header" ]; then
	echo "System Logs"
elif [ "$2" == "body" ]; then
	if [ -n "$(which journalctl)" ]; then
		echo "$(journalctl -rn 25 --no-pager)"
	elif [ -f /var/log/syslog ]; then
		echo "$(tail -n 25 /var/log/syslog)"
	elif [ -f /var/log/messages ]; then
		echo "$(tail -n 25 /var/log/messages)"
	else
		echo "No syslog system detected"
	fi
fi
