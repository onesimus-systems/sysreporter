#! /bin/bash
echo "Apache Error Log"

if [ -f /var/log/apache2/error.log ]; then
	echo "$(tail /var/log/apache2/error.log)"
else
	echo "Apache error log file not found"
fi
