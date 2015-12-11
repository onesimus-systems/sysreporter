#! /bin/bash
if [ "$2" == "header" ]; then
    echo "Last Boot Time"
elif [ "$2" == "body" ]; then
    # who -b has leading whitespace, use sed to trim it
    echo $(who -b | sed -e 's/^[[:space:]]*//')
fi
