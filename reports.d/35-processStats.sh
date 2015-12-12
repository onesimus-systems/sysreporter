#! /bin/bash
if [ "$2" == "header" ]; then
    echo "Process Stats"
elif [ "$2" == "body" ]; then
    if [ -z "$(which pidstat)" ]; then
    	echo "sysstat is not installed, can't run pidstat"
    	exit 1
    fi
    echo "$(pidstat)"
fi
