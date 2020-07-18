pipeline {
    agent any 
    tools {
        jdk 'java-8'
        maven 'M3'
    }
    stages {
        stage('Clone Repo') {
            steps {
                git url: 'https://github.com/hernanku/store-webapp-sample.git'
            }
        }
        stage('Build') {
            steps {
                sh '''
                ls -ld 'store-webapp-sample'
                '''
            }
        }
    }
}




