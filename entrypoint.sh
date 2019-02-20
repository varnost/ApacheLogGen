#!/bin/bash

if [ -z $LS_HOST ]; then
  lshost=$LS_HOST
else
  lshost=localhost
fi

if [ -z $LS_PORT ]; then
  lsport=$LS_PORT
else
  lsport=5044
fi

sed -i "s/%%PLACEHOLDER%%/$lshost/" /etc/filebeat/filebeat.yml

service filebeat start


if [ -z $@ ]; then
  ARGS="-n 0 -s 10"
else
  ARGS=$@
fi

python /usr/share/log-gen/apache-fake-log-gen.py -o LOG -p /var/log/apache/ $ARGS