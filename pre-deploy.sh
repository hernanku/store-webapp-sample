#!/bin/sh
serverName="devops@appserver01.trulabz.com"
password="CrocFly23"

sshpass -p "$password" ssh -o StrictHostKeyChecking=no "$serverName" << EOF
  sudo mkdir -p /apps/store-app
  sudo chown -R devops:devops /apps
  cd /apps/store-app
  ls -ltr
  sudo netstat -tunlp
  fuser -k 8080/tcp
  rm -rf *
  ls -ltr
EOF

sshpass -p "$password" scp -rp target/*.jar "$serverName":/apps/store-app
sshpass -p "$password" scp -rp artifact_deploy.sh "$serverName":/apps/store-app

sh deploy.sh
