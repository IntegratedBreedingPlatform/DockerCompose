## Pre-requisites
* docker and docker-compose is installed
* IPV4 forwarding is enabled - net.ipv4.ip_forward=1
* a [dockerhub](https://hub.docker.com/) account with access to the bmsapp repo. For external dev teams access requests can be performed via our [HelpDesk](https://ibplatform.atlassian.net/servicedesk/customer/portal/4/group/30/create/60)

## Configurations
* **.env.example** - this is where we setup environment variables utilized by the docker compose configuration. In order to use it it must be renamed to .env
* **config** - this contains the configuration files for the BMSScripts inside bmsapp.
* **mysql/conf** - this contains mysql configuration that is bind mounted to the mysql container on launch.
* **nginx** - this contains nginx configuration that is bind mounted to the nginx-proxy container on launch.
* **docker-compose.yml** - this default configuration is a basic setup of bmsapp with its own database that can be ported to 8080 or 80.
* **docker-compose-ssl.yml** - this is a setup that uses 4 containers to serve the bmsapp via HTTPS. The TLS Certificate is created and reenwed by the letsencrypt container and the requests are handled by the nginx-proxy container.
* **multi-docker-compose-proxy.yml** - this configuration is used when launching multiple instances of the bmsapp in a single server.
* **multi-docker-compose-app.yml** - this configuration is used when launching multiple instances of the bmsapp in a single server.
* **setup.sh** - a bash script for setting up a multi-container app in a single server.

## Running the containers

### Clone DockerCompose
```
git clone git@github.com:IntegratedBreedingPlatform/DockerCompose.git
```

### Copy the .env.sample to .env and change the values accordingly
```
BMS_IMG_URI=ibpbmsapp/bmsapp
BMS_RELEASE=15.0
BMS_DB_PASS=CHANGE_PASSWORD
```
### Once the env variables are set, run the bmsdock containers via docker-compose
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
