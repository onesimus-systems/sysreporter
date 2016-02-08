#! /bin/bash
echo "smartctl results"

for x in `smartctl -a --scan | cut -d ' ' -f 1`; do
  echo --------- $x ---------
  smartctl -H $x
done
