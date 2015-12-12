#! /bin/bash
echo "Nginx Access Log"

if [ -f /var/log/nginx/access.log ]; then
	echo "$(tail /var/log/nginx/access.log)"
else
	echo "Nginx access log file not found"
fi
