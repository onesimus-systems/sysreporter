#! /bin/bash
if [ "$2" == "header" ]; then
	echo "Nginx Error Log"
elif [ "$2" == "body" ]; then
	TAIL="$(tail /var/log/nginx/error.log 2> /dev/null)"
	if [ $? != 0 ]; then
		echo "Nginx error log file not found"
	fi
	echo $TAIL
fi
