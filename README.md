## Pre-requisites
* docker and docker-compose is installed
* IPV4 forwarding is enabled - net.ipv4.ip_forward=1


## Running the containers

* Copy the .env.sample to .env and change the values accordingly
```
BMS_IMG_URI=ibpbmsapp/bmsapp
BMS_RELEASE=14.0
BMS_DB_PASS=CHANGE_PASSWORD
```
* Once the env variables are set, run the bmsdock containers via docker-compose
```
$ cd bmsdocker
$ docker-compose up -d
...
...
Creating bmsdocker_bmsmysql_1 ... done
Creating bmsdocker_bmsapp_1   ... done
```
* Check in web browser after 3-5 mins if the application launched
http://localhost/ibpworkbench/main

That's it!
