#!/bin/bash
# Greg Hermo greg@leafnode.io
# Octoberber 2020

if [ $# -eq 0 ]
  then
    echo "No version specified"
    exit;
fi

docker-compose down
sed -i -e /^BMS_RELEASE/d .env
sed -i -e "1 a BMS_RELEASE=$1" .env
docker-compose up -d