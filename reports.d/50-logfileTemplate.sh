#!/bin/bash
#
# Use this as a template for simple log file reports.
# This report will get the last 5 lines of a file

# Report Title
echo "Report Title"

# Logfile to get
LOGFILE="/path/to/logfile.log"
if [ -f $LOGFILE ]; then
	tail -n 5 $LOGFILE
else
	echo "No log file"
fi
