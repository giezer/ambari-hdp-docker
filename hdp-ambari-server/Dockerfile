FROM reg.itoa.servicos.bb.com.br:5000/itoa/hdp-base:2.6.5-rf11
LABEL author="Giezer Funari"
LABEL version="0.1"

# Install packages
RUN apt-get update && apt-get install -y ambari-server && ambari-server setup -v -s

ENV no_proxy="localhost,127.0.0.1,node1,node2,node3,namenode,master,resourcemanager,ambari"

ADD ambari-shell.jar /tmp/
ADD install-cluster.sh /tmp/
ADD wait-for-host-number.sh /tmp/
ADD blueprint.json /tmp/
ADD hosts.json /tmp/
WORKDIR /tmp
RUN chmod 775 /var/lib/ambari-server/data/tmp/
EXPOSE 8080
ADD scripts/start.sh  /root/scripts/ambari-server-start.sh
ADD HDP-2.6.5.0-292.xml /tmp/HDP-2.6.5.0-292.xml
ADD ambari-hdp-1.list /etc/apt/sources.list.d/ 

CMD ["/root/scripts/ambari-server-start.sh"]
