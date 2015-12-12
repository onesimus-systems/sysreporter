#! /bin/bash
echo "Apache Access Log"

if [ -f /var/log/apache2/access.log ]; then
	echo "$(tail /var/log/apache2/access.log)"
else
	echo "Apache access log file not found"
fi

if [ -f /var/log/apache2/ssl_access.log ]; then
	echo "$(tail /var/log/apache2/ssl_access.log)"
else
	echo "Apache SSL access log file not found"
fi
