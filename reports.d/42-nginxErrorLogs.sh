#! /bin/bash
echo "Nginx Error Log"

if [ -f /var/log/nginx/error.log ]; then
	echo "$(tail /var/log/nginx/error.log)"
else
	echo "Nginx error log file not found"
fi
