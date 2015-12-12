#! /bin/bash
# $1 = Filename of calling reporter
# $2 = What to echo, either "header" or "body", this may expand in the future

# Don't output anything as this is simply a template
exit 0 # Remove this line before using as template

if [ "$2" == "header" ]; then
	echo ""
elif [ "$2" == "body" ]; then
	echo ""
fi
