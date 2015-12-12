#! /bin/bash
if [ "$2" == "header" ]; then
	echo 'Disk/CPU IO Stats'
elif [ "$2" == "body" ]; then
	if [ -z "$(which iostat)" ]; then
		echo "sysstat is not installed, can't run iostat"
		exit 1
	fi
	echo "$(iostat)"
fi
