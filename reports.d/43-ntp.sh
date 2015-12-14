#! /bin/bash
echo "NTP Statistics"

if [ -n "$(which ntpq)" ]; then
	echo "$(ntpq -p)"
else
	echo "ntpq not installed"
fi

echo

if [ -n "$(which ntpstat)" ]; then
	echo "$(ntpstat)"
else
	echo "ntpstat not installed"
fi
