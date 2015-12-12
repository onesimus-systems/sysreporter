#! /bin/bash
echo "Disk/CPU IO Stats"

if [ -z "$(which iostat)" ]; then
	echo "sysstat is not installed, can't run iostat"
	exit 1
fi
echo "$(iostat)"
