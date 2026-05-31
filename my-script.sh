#!/bin/bash

sudo apt update
sudo apt install -y nodejs npm

DownloadUrl=$(curl -s -u "john:titobi123" "http://159.203.7.145:8081/service/rest/v1/components?repository=npm-snapshots" | jq -r '.items[0].assets[0].downloadUrl')

if [ "$DownloadUrl" = "null" || "DownloadUrl" = "" ]
  then
    echo "error finding download url"
    exit 1
fi

echo "Downloadurl: $DownloadUrl"
wget "$DownloadUrl"

tar -xzvf bootcamp-node-project-1.0.0.tgz

if [ -d "package" ]
  then
    cd package
  else
    echo "directory does not exist"
    exit 1
fi

npm install
npm start

