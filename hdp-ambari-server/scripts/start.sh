#!/bin/bash

service ssh start
service ntp start

#dinamic etc hosts
ping -q -c 1 master | grep PING | sed -e "s/).*//" | sed -e "s/.*(//" | awk '{print $1 " master"}' >> /etc/hosts
ping -q -c 1 namenode | grep PING | sed -e "s/).*//" | sed -e "s/.*(//" | awk '{print $1 " namenode"}' >> /etc/hosts
ping -q -c 1 resourcemanager | grep PING | sed -e "s/).*//" | sed -e "s/.*(//" | awk '{print $1 " resourcemanager"}' >> /etc/hosts
ping -q -c 1 node1 | grep PING | sed -e "s/).*//" | sed -e "s/.*(//" | awk '{print $1 " node1"}' >> /etc/hosts
ping -q -c 1 node2 | grep PING | sed -e "s/).*//" | sed -e "s/.*(//" | awk '{print $1 " node2"}' >> /etc/hosts
ping -q -c 1 node3 | grep PING | sed -e "s/).*//" | sed -e "s/.*(//" | awk '{print $1 " node3"}' >> /etc/hosts

#install mpack hdf
ambari-server install-mpack --mpack=http://public-repo-1.hortonworks.com/HDF/ubuntu16/3.x/updates/3.1.1.0/tars/hdf_ambari_mp/hdf-ambari-mpack-3.1.1.0-35.tar.gz --verbose

while [ -z "$(netstat -tulpn | grep 8080)" ]; do
  ambari-server start
  sleep 5
done

/tmp/install-cluster.sh

while true; do
  sleep 5
  tail -f /dev/null
done


