
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

        stage('COde Quality Check SonarQube') {
            environment {
                scannerHome = tool 'sonar_scanner'
            }
            steps {
                withSonarQubeEnv('sonarServer') {
                    sh "${scannerHome}/bin/sonar-scanner" \
                        -Dsonar.projectKey=store-app-codeCheck \
                        -Dsonar.host.url=http://sonarqd01.trulabz.com:9000 \
                        -Dsonar.login=d6421646b431030bd7ea671b33d8a71db335da7f
                }
                timeout(time: 10, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
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
                sh "sh pre-deploy.sh"
            }
        }
    }
}




