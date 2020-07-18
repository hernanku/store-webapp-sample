#!/bin/sh

sshpass -p 'CrocFly23' ssh -o StrictHostKeyChecking=no devops@javad01.trulabz.com << EOF
  cd /apps/store-app
  ls -ltr
  sudo netstat -tunlp
  fuser -k 8080/tcp
  rm -rf *
  ls -ltr
EOF

scp -rp target/*.jar devops@javad01.trulabz.com:/apps/store-app
scp -rp artifact_deploy.sh devops@javad01.trulabz.com:/apps/store-app


sh deploy.sh
