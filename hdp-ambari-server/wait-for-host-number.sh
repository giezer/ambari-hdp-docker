#!/bin/bash

: ${AMBARI_HOST:=ambari}
: ${EXPECTED_HOST_COUNT:=6}
: ${SLEEP:=2}
: ${DEBUG:=1}
export no_proxy="localhost,127.0.0.1,ambari"
: ${AMBARI_HOST:? ambari server address is mandatory, fallback is a linked containers exposed 8080}

debug() {
  [ $DEBUG -gt 0 ] && echo [DEBUG] "$@" 1>&2
}

get-connected-hosts() {
  CONNECTED_HOSTS=$(
  curl \
    --connect-timeout 2 \
    -u admin:admin \
    -H 'Accept: text/plain' \
    $AMBARI_HOST:8080/api/v1/hosts \
    2>/dev/null \
    | grep host_name \
    | wc -l
  )
  debug connected hosts: $CONNECTED_HOSTS
  echo $CONNECTED_HOSTS
}

get-server-state() {
  curl \
    --connect-timeout 2 \
    -u admin:admin \
    -H 'Accept: text/plain' \
    $AMBARI_HOST:8080/api/v1/check 
#    2>/dev/null
}

debug waits for ambari server: $AMBARI_HOST RUNNING ...
while ! get-server-state | grep RUNNING &>/dev/null ; do
  [ $DEBUG -gt 0 ] && echo -n .
  sleep $SLEEP
done
echo "saindo do loop de espera"
[ $DEBUG -gt 0 ] && echo

debug waits until $EXPECTED_HOST_COUNT hosts connected to server ...
while [ $(get-connected-hosts) -lt $EXPECTED_HOST_COUNT ] ; do
  sleep $SLEEP
done
