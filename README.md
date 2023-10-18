## Pre-requisites
* docker and docker-compose is installed
* IPV4 forwarding is enabled - net.ipv4.ip_forward=1
* a [dockerhub](https://hub.docker.com/) account with access to the bmsapp repo. For external dev teams access requests can be performed via our [HelpDesk](https://ibplatform.atlassian.net/servicedesk/customer/portal/4/group/30/create/60)

## Configurations
* **.env.sample** - this is where we setup environment variables utilized by the docker compose configuration. In order to use it it must be renamed to .env
* **config** - this contains the configuration files for the DBScripts inside bmsapp.
* **mysql/conf** - this contains mysql configuration that is bind mounted to the mysql container on launch.
* **nginx** - this contains nginx configuration that is bind mounted to the nginx-proxy container on launch.
* **docker-compose.yml** - this default configuration is a basic setup of bmsapp with its own database that can be ported to 8080 or 80.
* **docker-compose-ssl.yml** - this is a setup that uses 4 containers to serve the bmsapp via HTTPS. The TLS Certificate is created and renewed by the Let's Encrypt container and the requests are handled by the nginx-proxy container.
* **multi-docker-compose-proxy.yml** - this configuration is used when launching multiple instances of the bmsapp in a single server.
* **multi-docker-compose-app.yml** - this configuration is used when launching multiple instances of the bmsapp in a single server.
* **setup.sh** - a bash script for setting up a multi-container app in a single server.

## Running the containers

### Clone DockerCompose
```
git clone git@github.com:IntegratedBreedingPlatform/DockerCompose.git
```

### Checkout
```
git checkout tags/[VERSION]
```

### Copy the .env.sample to .env and change the values accordingly
```
BMS_IMG_URI=ibpbmsdocker/bmsapp
BMS_RELEASE=[VERSION]
BMS_DB_HOST=bmsmysql
BMS_DB_PASS=[PASSWORD]
```

### Update config/application.properties with final database connection paramters
```
### see BMS_DB_HOST in .env
db.host=bmsmysql

### see BMS_DB_PASS in .env
db.password=[PASSWORD]
```

### Once the env variables and db connection parameters are set, run the bmsdock containers via docker-compose
```
$ cd DockerCompose
$ docker-compose up -d
...
...
Creating dockercompose_bmsmysql_1 ... done
Creating dockercompose_bmsapp_1   ... done
```
### Check in web browser after 3-5 mins if the application launched
http://localhost/ibpworkbench/main

That's it!

### For more information, please visit the Wiki https://github.com/IntegratedBreedingPlatform/DockerCompose/wiki/BMS-on-Docker-Compose-(CentOS-Linux)
