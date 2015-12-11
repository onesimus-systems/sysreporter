#! /bin/bash
if [ "$2" == "header" ]; then
    echo 'Disk/CPU IO Stats'
elif [ "$2" == "body" ]; then
    echo "$(iostat)"
fi
