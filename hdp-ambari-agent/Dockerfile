FROM reg.itoa.servicos.bb.com.br:5000/itoa/hdp-base:2.6.5-rf6
LABEL author "Amar Mesic"
LABEL version "0.1"


RUN apt-get install -y ambari-agent \
        ambari-metrics-* \
	ambari-logsearch-* \
	hadoop* \
	libhdfs0 \
	openssl \
	zookeeper \
	hbase \
	hive* \
	tez \
	phoenix* \
	ranger* \
	storm* \
	kafka* \
	pig* \
	sqoop \
	mahout \
	flume* \
	datafu* \
	spark* \
	spark2* \
	livy* \
	livy2* \
	zeppelin* \
	accumulo \
	falcon* \
	oozie* \
	slider* \
	liblzo2-2 \
	liblzo2-dev \
	hadooplzo  \
	libsnappy1v5 \
	libsnappy-dev \
	rpcbind

RUN sed -i '/^hostname=.*$/c\hostname=ambari' /etc/ambari-agent/conf/ambari-agent.ini

# Add startup scripts
ADD scripts/start.sh /root/scripts/ambari-agent-start.sh
ENTRYPOINT ["/root/scripts/ambari-agent-start.sh"]
