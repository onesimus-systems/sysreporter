#! /bin/bash
if [ "$2" == "header" ]; then
    echo "Disk Usage"
elif [ "$2" == "body" ]; then
    echo "$(df -h -x cifs)"
fi
