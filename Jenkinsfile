pipeline {
    agent any 
    tools {
        maven 'M3'
    }
    stages {
        stage('Initialize') {
            steps {
                sh '''
                    echo "PATH = ${PATH}"
                    mvn -v
                '''
            }
        }
        stage('Build') {
            steps {
                echo 'This is a minimal pipeline.'
            }
        }
    }
}




