#!/bin/sh

sshpass -p 'CrocFly23' ssh -o StrictHostKeyChecking=no devops@javad01.trulabz.com << EOF
  cd /apps/store-app
  sh artifact_deploy.sh
  exit
EOF



