#!/bin/bash

service ssh start
service ntp start
ambari-agent start

while true; do
    tail -f /dev/null
done
