
// ## Define variables
def remote = [:]
remote.name = 'appDevServer'
remote.host = 'javad01.trulabz.com'
remote.user = 'devops'
remote.password = 'CrocFly23'
remote.allowAnyHosts = true

pipeline {

    agent any
    tools {
        maven 'M3'
        jdk 'java-8'
    }
    stages {
        stage ('Initialize') {
            steps {
                sh '''
                    echo "PATH = ${PATH}"
                    echo "M2_HOME = ${M2_HOME}"
                '''
            }
        }

        stage ('Build') {
            steps {
                sh 'mvn -Dmaven.test.failure.ignore=true clean package' 
            }
            post {
                success {
                    sh "ls -ltr '${env.WORKSPACE}'"
                    sh "ls -ltr '${env.WORKSPACE}/target'"
                }
            }
        }

        stage ('Deploy to App Server') {
            steps{
                sshCommand remote: remote, command: "ls -ltr /apps", sudo: true
                sshCommand remote: remote, command: "fuser -k 8080/tcp", sudo: true
                sshRemove remote: remote, path: "/apps/store-app/*.jar"
            }
        }
    }
}




