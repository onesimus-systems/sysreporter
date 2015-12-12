#! /bin/bash
if [ "$2" == "header" ]; then
	echo "Currently Logged In Users"
elif [ "$2" == "body" ]; then
	echo "$(w)"
fi
