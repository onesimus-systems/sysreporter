#! /bin/bash
echo "System Activity Report"

if [ -z "$(which sar)" ]; then
	echo "sysstat is not installed, can't run sar"
	exit 1
fi
echo "$(sar)"
