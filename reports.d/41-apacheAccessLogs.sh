#! /bin/bash
if [ "$2" == "header" ]; then
	echo "Apache Access Log"
elif [ "$2" == "body" ]; then
	TAIL="$(tail /var/log/apache2/access.log 2> /dev/null)"
	if [ $? != 0 ]; then
		echo "Apache access log file not found"
	fi
	echo $TAIL

	TAIL="$(tail /var/log/apache2/ssl_access.log 2> /dev/null)"
	if [ $? != 0 ]; then
		echo "Apache SSL access log file not found"
	fi
	echo $TAIL
fi
