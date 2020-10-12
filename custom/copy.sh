#!/bin/bash
# A simple shell script to copy custom files to the container.
# Greg Hermo greg@leafnode.io
# September 2020

if [ $# -eq 0 ]
  then
    echo "No container specified"
    exit;
fi

echo "Copying files..."

# The pattern to copy a file
# docker cp <filename> $1:<directory>/<filename>
# See example below
# docker cp vsni.lic $1:/bvdesign/bin/vsni.lic

echo "Done copying custom files..."