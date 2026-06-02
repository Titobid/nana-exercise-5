#!/bin/bash

sudo apt update
sudo apt install -y nodejs npm

Nexus_User=$1
Nexus_Password=$2
Nexus_URL=$3

DownloadUrl=$(curl -s -u "$Nexus_User:$Nexus_Password" "$Nexus_URL/service/rest/v1/components?repository=npm-snapshots" | jq -r '.items[0].assets[0].downloadUrl')

if [ "$DownloadUrl" = "null" ] || [ "DownloadUrl" = "" ]
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

