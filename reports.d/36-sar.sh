#! /bin/bash
if [ "$2" == "header" ]; then
    echo "System Activity Report"
elif [ "$2" == "body" ]; then
    if [ -z "$(which sar)" ]; then
    	echo "sysstat is not installed, can't run sar"
    	exit 1
    fi
    echo "$(sar)"
fi
