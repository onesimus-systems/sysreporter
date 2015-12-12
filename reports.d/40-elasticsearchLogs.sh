#! /bin/bash
echo "Elasticsearch Log"

if [ -f /var/log/elasticsearch/elk.log ]; then
	echo "$(tail -n 25 /var/log/elasticsearch/elk.log)"
else
	echo "Elasticsearch log file not found"
fi
