#! /bin/bash
if [ "$2" == "header" ]; then
	echo "Apache Error Log"
elif [ "$2" == "body" ]; then
	TAIL="$(tail /var/log/apache2/error.log 2> /dev/null)"
	if [ $? != 0 ]; then
		echo "Apache error log file not found"
	fi
	echo $TAIL
fi
