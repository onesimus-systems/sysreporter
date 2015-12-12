#! /bin/bash
if [ "$2" == "header" ]; then
	echo "Nginx Access Log"
elif [ "$2" == "body" ]; then
	TAIL="$(tail /var/log/nginx/access.log 2> /dev/null)"
	if [ $? != 0 ]; then
		echo "Nginx access log file not found"
	fi
	echo $TAIL
fi
