#!/bin/bash
die () {
    echo >&2 "$@"
    exit 1
}


echo "Setup a proxy or app?"
read PURPOSE

if [ "$PURPOSE" == "proxy" ]; then
    echo "Setting up a $PURPOSE server"
    echo "Enter the admin email below:"
    read ADMIN_EMAIL
    mv docker-compose.yml docker-compose.yml.bak
    cp  multi-docker-compose-proxy.yml docker-compose.yml
    cp .env.sample .env
    sed -i -e "s/#BMS_SSL_EMAIL=leafnodedev@leafnode.io/BMS_SSL_EMAIL=$ADMIN_EMAIL/g" .env
    echo "Do you want to run the proxy server now? (y/n)"
    read RUN
    if [ "$RUN" == "y" ]; then
            docker-compose up -d
            die "Done, proxy server now running"
    else
            die "Setup done, to run the server docker-compose up -d"
    fi
elif [ "$PURPOSE" == "app" ]; then
    echo "Setting up a $PURPOSE server"
    echo "Enter the BMS Release Version: (e.g. 15.4.2):"
    read BMS_VERSION
    echo "Enter the hostname: (bmsdock.leafnode.io):"
    read BMS_HOSTNAME
    echo "Enter the Database password to set:"
    read BMS_PASS
    echo "Enter the default crops: (e.g. maize,rice)"
    read BMS_CROPS
    echo "Enter the admin email below:"
    read ADMIN_EMAIL
    echo "Please verify the information below"
    echo "BMS Version - $BMS_VERSION"
    echo "BMS Host - $BMS_HOSTNAME"
    echo "BMS Password - $BMS_PASS"
    echo "BMS Crops - $BMS_CROPS"
    echo "BMS Admin Email - $ADMIN_EMAIL"

    BMS_MYSQL=$(echo "$BMS_HOSTNAME" | tr -dc '[:alnum:]\n\r')
    count_apps=$(docker ps -q -f name=bmsapp | wc -l)
    BMS_PORT_PREFIX=$((count_apps + 1))

    echo "Confirm? (y/n)"
    read RUN
    if [ "$RUN" != "y" ]; then
            die "Setup discontinued."
    fi

    mv docker-compose.yml docker-compose.yml.bak
    cp  multi-docker-compose-app.yml docker-compose.yml
    cp .env.sample .env
    cp config/application.properties.orig config/application.properties

    sed -i -e "s/BMS_RELEASE=15.0/BMS_RELEASE=$BMS_VERSION/g" .env
    sed -i -e "s/BMS_DB_HOST=bmsmysql/BMS_DB_HOST=$BMS_MYSQL/g" .env
    sed -i -e "s/BMS_DB_PASS=CHANGE_PASSWORD/BMS_DB_PASS=$BMS_PASS/g" .env
    sed -i -e "s/BMS_CROPS=maize/BMS_CROPS=$BMS_CROPS/g" .env
    sed -i -e "s/#BMS_SSL_HOST=bmsdock.leafnode.io/BMS_SSL_HOST=$BMS_HOSTNAME/g" .env
    sed -i -e "s/#BMS_SSL_EMAIL=leafnodedev@leafnode.io/BMS_SSL_EMAIL=$ADMIN_EMAIL/g" .env
    sed -i -e "s/#BMS_SCHEME=https/BMS_SCHEME=https/g" .env
    sed -i -e "s/#BMS_PORT=443/BMS_PORT=443/g" .env
    sed -i -e "s/db.host=bmsmysql-1/db.host=$BMS_MYSQL/g" ./config/application.properties
    sed -i -e "s/db.password=CHANGE_PASSWORD/db.password=$BMS_PASS/g" ./config/application.properties
    sed -i -e "s/bmsmysql-1/$BMS_MYSQL/g" docker-compose.yml
    sed -i -e "s/18080/${BMS_PORT_PREFIX}8080/g" docker-compose.yml
    sed -i -e "s/13306/${BMS_PORT_PREFIX}3306/g" docker-compose.yml

    echo "Do you want to run the app server now? (y/n)"
    read RUN
    if [ "$RUN" == "y" ]; then
            docker-compose up -d
            die "Done, app server now running"
    else
            die "Setup done, to run the server docker-compose up -d"
    fi
else
    die "Invalid Argument"
fi