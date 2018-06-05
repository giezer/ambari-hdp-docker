FROM reg.itoa.servicos.bb.com.br:5000/itoa/hdp-base:2.6.5-rf11
LABEL author "Amar Mesic"
LABEL version "0.1"


RUN apt-get install -y ambari-agent \
        ambari-metrics-* \
	hadoop-yarn \
	hadoop-hdfs \
	hadoop-client \
	hadoop-mapreduce \
	hadoop-hdfs-secondarynamenode \
	libhdfs0 \
	openssl \
	zookeeper \
	tez \
	pig \
	liblzo2-2 \
	liblzo2-dev \
	hadooplzo  \
	libsnappy1v5 \
	libsnappy-dev \
	rpcbind
ENV no_proxy="localhost,127.0.0.1,node1,node2,node3,namenode,master,resourcemanager,ambari"
RUN sed -i '/^hostname=.*$/c\hostname=ambari' /etc/ambari-agent/conf/ambari-agent.ini

# Add startup scripts
ADD scripts/start.sh /root/scripts/ambari-agent-start.sh
ENTRYPOINT ["/root/scripts/ambari-agent-start.sh"]
