#! /bin/bash
if [ "$2" == "header" ]; then
	echo 'Last 10 Logged In Users'
elif [ "$2" == "body" ]; then
	echo "$(last -n 10)"
fi
