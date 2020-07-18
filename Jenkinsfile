pipeline {
    agent any 
    tools {
        maven 'M2'
    }
    stages {
        stage('Initialize') {
            steps {
                sh '''
                    echo "PATH = ${PATH}"
                    echo "M2_HOME = ${M2}
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




