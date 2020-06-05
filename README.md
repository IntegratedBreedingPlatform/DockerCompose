## Pre-requisites
* docker and docker-compose is installed
* IPV4 forwarding is enabled - net.ipv4.ip_forward=1
* a [dockerhub](https://hub.docker.com/) account with access to the bmsapp repo. For external dev teams access requests can be performed via our [HelpDesk](https://ibplatform.atlassian.net/servicedesk/customer/portal/4/group/30/create/60)
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
Creating bmsdocker_bmsmysql_1 ... done
Creating bmsdocker_bmsapp_1   ... done
```
### Check in web browser after 3-5 mins if the application launched
http://localhost/ibpworkbench/main

Log in with admin - @dm1N and change your user information.

That's it!
