#!/bin/bash
# Author: Lee Keitel
# Version: 3.0.0a
# License: MIT
#

## Script version
VERSION="3.0.0a"

## Directory of running script
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTPATH="$DIR/$(basename $0)"

## Current datetime
DATENOW="$(date "+%F %H:%M:%S")"

## Import server specific configuration
if [ -f /etc/sysreporter.conf ]; then
	source /etc/sysreporter.conf
elif [ -f "$DIR/sysreporter.conf" ]; then
	source "$DIR/sysreporter.conf"
else
	>2& echo "No configuration file found"
	exit 1
fi

# Script variables
## File for temporary output of currently compiled log, truncated on each run
LOGFILE="$TEMPDIR/compiledlog.log"

## Temp file for compiling email message
TEMPMAIL="$TEMPDIR/mail"

## Functions
cleanup() {
	cat /dev/null > "$LOGFILE"
	cat /dev/null > "$TEMPMAIL"
}

print_to_report() {
	echo -e "$1" >> "$LOGFILE"
}

print_header() {
	print_to_report ">>> $1 <<<\n"
}

cmd_show() {
	SAVEIFS=$IFS
	IFS=$(echo -en "\n\b")
	for f in $REPORTSDIR; do
		if [ -x "$f" ]; then
			echo $(basename $f)
		fi
	done
	IFS=$SAVEIFS
}

cmd_enable_disable() {
	MODE="$1"

	SAVEIFS=$IFS
	IFS=$(echo -en "\n\b")
	for f in $REPORTSDIR; do
		FILE="$(basename $f)"
		if [[ "$FILE" =~ "$2" ]]; then
			case "$MODE" in
				enable)
					echo "Enabling $FILE"
					chmod +x $f
					;;
				disable)
					echo "Disabling $FILE"
					chmod -x $f
			esac
		fi
	done
	IFS=$SAVEIFS
}

cmd_run() {
	cleanup
	print_header "$TITLE"

	SAVEIFS=$IFS
	IFS=$(echo -en "\n\b")
	for f in $REPORTSDIR; do
		if [ -x "$f" ]; then
			print_header "$($f $SCRIPTPATH header)"
			print_to_report "$($f $SCRIPTPATH body)"
			print_to_report
		fi
	done
	IFS=$SAVEIFS

	mail_report
	return
}

mail_report() {
	if ! $EMAIL_REPORT; then
		return 0
	fi

	if [ -z "$(which ssmtp)" ]; then
		>&2 echo "Can't send mail, ssmtp not installed"
		return 1
	fi

	if [ -z "$EMAIL_ADDRESSES" ]; then
		>&2 echo "No email addresses specified, can't send email"
		return 1
	fi

	echo "To: $EMAIL_ADDRESSES" >> "$TEMPMAIL"
	echo "From: $EMAIL_FROM" >> "$TEMPMAIL"
	echo "Subject: $EMAIL_SUBJECT" >> "$TEMPMAIL"
	echo >> "$TEMPMAIL"
	cat "$LOGFILE" >> "$TEMPMAIL"
	ssmtp "$EMAIL_ADDRESSES" < "$TEMPMAIL"
}

cmd_usage() {
	cmd_version
	echo
	echo "Usage: $0 [command]"
	echo
	echo "Commands:"
	echo "    run"
	echo "    show"
	echo "    enable"
	echo "    disable"
	echo "    help"
	echo "    version"
}

cmd_version() {
	echo "System Reporter"
	echo "Get system stats and email them to a sysadmin"
	echo "Version $VERSION"
}

## Dispatch command to appropiate function
case "$1" in
	run) shift;				cmd_run "$@" ;;
	show) shift;			cmd_show "$@" ;;
	enable|disable) 		  cmd_enable_disable "$@" ;;
	help|--help) shift;		cmd_usage "$@" ;;
	version|--version) shift;  cmd_version "$@" ;;
	*) cmd_usage "$@" ;;
esac
exit 0
