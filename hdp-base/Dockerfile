FROM ubuntu:16.04
LABEL author="Amar Mesic"
LABEL version="0.1"

# Setup repos and install pre-requisites
ENV LANG C.UTF-8
RUN apt-get -qq update
RUN apt-get update && apt-get install wget ntp dnsutils net-tools inetutils-ping curl ssh vim python telnet lsof less apt-utils -y
RUN apt-get update && apt-get install -y \
		bzip2 \
		unzip \
		xz-utils \
&& rm -rf /var/lib/apt/lists/*
RUN mkdir /usr/java/
RUN chmod a+x  /usr/java/
RUN mkdir /usr/jdk64/
RUN chmod a+x /usr/jdk64/
RUN wget http://public-repo-1.hortonworks.com/ARTIFACTS/jdk-8u112-linux-x64.tar.gz -O /tmp/jdk-8u112-linux-x64.tar.gz
RUN tar --no-same-owner -xzvf /tmp/jdk-8u112-linux-x64.tar.gz /usr/jdk64
RUN chmod -r 644 /usr/jdk64/
RUN ln -s /usr/jdk64/jdk1.8.0_112 /usr/java/default
ENV JAVA_HOME=/usr/jdk64/jdk1.8.0_112

# Add HDP and Ambari repos
ADD ambari.list /etc/apt/sources.list.d/ 
ADD hdp.list /etc/apt/sources.list.d/ 
ADD hdp.gpl.list /etc/apt/sources.list.d/ 
ADD hdf.list /etc/apt/sources.list.d/ 
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys B9733A7A07513CAD
RUN apt-get update
WORKDIR /tmp

# Create directories
RUN mkdir /root/.ssh && mkdir /root/scripts && mkdir /root/config

# Set up SSH
ADD config/id_rsa /root/.ssh/id_rsa
ADD config/id_rsa.pub /root/.ssh/id_rsa.pub
ADD config/sshd_config /etc/ssh/sshd_config
RUN touch /root/.ssh/authorized_keys \
    && cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys \
    && chmod -R 600 /root/.ssh/

# Set up hosts
ADD config/hosts /etc/
CMD ["/bin/bash"]
