#! /bin/bash
echo "NTP Statistics"

if [ -n "$(which ntpq)" ]; then
	echo "$(ntpq -p 2>&1)"
fi

echo

if [ -n "$(which chronyc)" ]; then
	echo "$(chronyc sources)"
fi