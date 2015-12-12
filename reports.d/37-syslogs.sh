#! /bin/bash
echo "System Logs"

if [ -n "$(which journalctl)" ]; then
	echo "$(journalctl -rn 25 --no-pager)"
elif [ -f /var/log/syslog ]; then
	echo "$(tail -n 25 /var/log/syslog | tac)"
elif [ -f /var/log/messages ]; then
	echo "$(tail -n 25 /var/log/messages | tac)"
else
	echo "No syslog system detected"
fi
