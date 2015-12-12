#! /bin/bash
echo "Last Boot Time"
# who -b has leading whitespace, use sed to trim it
echo $(who -b | sed -e 's/^[[:space:]]*//')
