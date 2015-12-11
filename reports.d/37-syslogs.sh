#! /bin/bash
if [ "$2" == "header" ]; then
    echo "System Logs"
elif [ "$2" == "body" ]; then
    echo "$(tail -n 25 /var/log/syslog)"
fi
