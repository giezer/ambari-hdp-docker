#!/bin/bash

service ssh start
service ntp start

ping -q -c 1 master | grep PING | sed -e "s/).*//" | sed -e "s/.*(//" | awk '{print $1 " master"}' >> /etc/hosts
ping -q -c 1 ambari | grep PING | sed -e "s/).*//" | sed -e "s/.*(//" | awk '{print $1 " ambari"}' >> /etc/hosts
ping -q -c 1 resourcemanager | grep PING | sed -e "s/).*//" | sed -e "s/.*(//" | awk '{print $1 " resourcemanager"}' >> /etc/hosts
ping -q -c 1 node1 | grep PING | sed -e "s/).*//" | sed -e "s/.*(//" | awk '{print $1 " node1"}' >> /etc/hosts
ping -q -c 1 node2 | grep PING | sed -e "s/).*//" | sed -e "s/.*(//" | awk '{print $1 " node2"}' >> /etc/hosts
ping -q -c 1 node3 | grep PING | sed -e "s/).*//" | sed -e "s/.*(//" | awk '{print $1 " node3"}' >> /etc/hosts

ambari-agent start

while true; do
    tail -f /dev/null
done
