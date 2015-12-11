#! /bin/bash
if [ "$2" == "header" ]; then
    echo "Process Stats"
elif [ "$2" == "body" ]; then
    echo "$(pidstat)"
fi
