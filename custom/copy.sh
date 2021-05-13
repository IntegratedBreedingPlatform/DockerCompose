#!/bin/bash
# This script extracts the bms war files and copies files to the container as specified in the files.txt
# Greg Hermo greg@leafnode.io
# September 2020

echo "Extracting war files..."
cd /usr/local/tomcat/webapps
[ ! -d bmsapi ] && unzip bmsapi.war -d bmsapi
[ ! -d Fieldbook ] && unzip Fieldbook.war -d Fieldbook
[ ! -d GDMS ] && unzip GDMS.war -d GDMS
[ ! -d ibpworkbench ] && unzip ibpworkbench.war -d ibpworkbench
[ ! -d inventory-manager ] && unzip inventory-manager.war -d inventory-manager
echo "DONE extracting war files..."

echo "Copying files..."
while IFS="" read -r p || [ -n "$p" ]
do
  FILE="/custom/$(cut -d':' -f1 <<<"$p")"
  FOLDER="$(cut -d':' -f2 <<<"$p")"
  [ -f $FILE ] && [ -d $FOLDER ] && { printf '%s\n' "Copying $FILE to $FOLDER"; cp -f $FILE $FOLDER; }
done < /custom/files.txt

# The pattern to copy a file
# docker cp <filename> $1:<directory>/<filename>
# See example below
# docker cp vsni.lic $1:/bvdesign/bin/vsni.lic

echo "=> Done copying custom files."

# Sleep for 10s before starting tomcat to make sure
# mysql has completely started to avoid issue when
# creating fresh databases - workbench, maize, etc.
sleep 10

echo "=> Starting tomcat..."
/bin/bash /run.sh