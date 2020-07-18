#!/bin/sh
password="CrocFly23"

sshpass -p "$password" ssh -o StrictHostKeyChecking=no devops@javad01.trulabz.com << EOF
  cd /apps/store-app
  ls -ltr
  sudo netstat -tunlp
  fuser -k 8080/tcp
  rm -rf *
  ls -ltr
EOF

sshpass -p "$password" scp -rp target/*.jar devops@javad01.trulabz.com:/apps/store-app
sshpass -p "$password" scp -rp artifact_deploy.sh devops@javad01.trulabz.com:/apps/store-app


sh deploy.sh
