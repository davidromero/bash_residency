#!/bin/bash
echo "Processing download speed..."
echo "" > result.txt
speedtest-cli > result.txt
HOST_NAME=$(grep -m 1 Testing result.txt)
DOWN_SPEED=$(grep Download result.txt)
DATE_NOW=$(date)
USER_NAME=$(whoami)
mongo internetspeeddb --eval 'db.downspeed.insertOne( { user: "'"${USER_NAME}"'", host_name: "'"${HOST_NAME}"'", speed: "'"${DOWN_SPEED}"'", date : "'"${DATE_NOW}"'" } );' --host 127.0.0.1:27017

