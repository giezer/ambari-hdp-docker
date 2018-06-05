Dockerfiles and Docker Compose for setting up an multi-node HDP Cluster with Ambari 2.6. Docker images are based on Ubuntu 16.04. 

Included the ambari shell for the automatic creation of the cluster and installation of the components according to the blueprint.
More about ambari shell https://github.com/hortonworks/ambari-shell

Requires Docker > v1.13 and Docker Compose > v1.17

## Docker cluster layout
![HDP on Docker Architecture](assets/docker.png)

## Build images

1. Build HDP Base Image
```
cd hdp-base
docker build -t amarmesic/hdp-base:latest .
```

2. Build Ambari Agents Images
```
cd hdp-ambari-agent-datanode
docker build -t amarmesic/hdp-datanode:latest .
cd hdp-ambari-agent-namenode
docker build -t amarmesic/hdp-namenode:latest .
cd hdp-ambari-agent-resourcemanager
docker build -t amarmesic/hdp-resourcemanager:latest .
cd hdp-ambari-agent-master
docker build -t amarmesic/hdp-master:latest .

The build of the images has been separated because the binaries are already installed, so the installation of the components is faster.

```

3. Build Ambari Server Image
```
cd hdp-ambari-server
docker build -t amarmesic/hdp-ambari-server:latest .
```

## Run Docker Compose
To start containers, use Docker Compose
```
docker-compose up -d
```
It will take about a minute until Ambari is available on port 8080

```

## Run in rancher
This compose rolled into the rancher. Hence the change in the container names of the original project. 
The rancher does not accept special characters in container names.
In the rancher docker-compose also does not need the network it already does this automatically. 
Because of this the dynamic creation of the containers' hosts file was done.

More about rancher https://github.com/rancher/rancher

```
It will take about a minute until Ambari is available on port 8080

```


## Passwords

Admin/Database password for all services is `hadoop`

