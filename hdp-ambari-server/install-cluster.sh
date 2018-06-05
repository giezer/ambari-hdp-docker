#!/bin/bash

: ${AMBARI_HOST:=ambari}
echo $AMBARI_HOST
: ${BLUEPRINT:=/tmp/blueprint.json}
echo $BLUEPRINT
: ${HOSTS:=/tmp/hosts.json}
echo $HOSTS

export no_proxy="localhost,127.0.0.1,ambari"
echo AMBARI_HOST=${AMBARI_HOST:? ambari server address is mandatory, fallback is a linked containers exposed 8080}

./wait-for-host-number.sh

curl -v -k -u admin:admin -H "X-Requested-By:ambari" -X POST http://ambari:8080/api/v1/version_definitions -d '{"VersionDefinition": { "version_url" : "file:/tmp/HDP-2.6.5.0-292.xml" }  }'

/usr/jdk64/jdk1.8.0_112/bin/java -jar ambari-shell.jar --ambari.host=$AMBARI_HOST << EOF
blueprint add --file $BLUEPRINT
cluster build --blueprint bp
cluster assign --host master --hostGroup host_group_1
cluster assign --host namenode --hostGroup host_group_2
cluster assign --host resourcemanager --hostGroup host_group_4
cluster assign --host node1 --hostGroup host_group_3
cluster assign --host node2 --hostGroup host_group_3
cluster assign --host node3 --hostGroup host_group_3
cluster create --exitOnFinish true
EOF
