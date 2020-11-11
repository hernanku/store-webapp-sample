#!/bin/sh
serverName="devops@javad01.trulabz.com"
password="CrocFly23"

sshpass -p "$password" ssh -o StrictHostKeyChecking=no "$serverName" << EOF
  cd /apps/store-app
  nohup java -jar *.jar < /dev/null > nohup.out 2>&1 &
  exit
EOF



