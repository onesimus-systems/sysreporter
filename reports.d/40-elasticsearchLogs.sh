#! /bin/bash
if [ "$2" == "header" ]; then
	echo "Elasticsearch Log"
elif [ "$2" == "body" ]; then
	TAIL="$(tail /var/log/elasticsearch/elk.log 2> /dev/null)"
	if [ $? != 0 ]; then
		echo "Elasticsearch log file not found"
	fi
	echo $TAIL
fi
