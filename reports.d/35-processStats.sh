#! /bin/bash
echo "Process Stats"

if [ -z "$(which pidstat)" ]; then
	echo "sysstat is not installed, can't run pidstat"
	exit 1
fi
echo "$(pidstat)"
