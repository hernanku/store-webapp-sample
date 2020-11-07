
pipeline {

    agent any
    tools {
        maven 'M3'
        jdk 'java-8'
    }
    stages {
        stage('Clone Repo') {
            steps {
                git branch: 'feature/pydeploy', url: "https://github.com/hernanku/store-webapp-sample.git"
            }
        }
        stage('Code Quality Check with SonarQube') {
            environment {
                scannerHome = tool 'sonar_scanner'
            }
            steps {
                withSonarQubeEnv('sonarServer') {
                    sh "${scannerHome}/bin/sonar-scanner \
                        -Dsonar.projectKey=webstore-app \
                        -Dsonar.host.url=https://sonarqube01.trulabz.com \
                        -Dsonar.login=350f46e8450bd05bc1be70fdf9d9366eebfeb89a \
                        -Dsonar.sources=src/main/java/ \
                        -Dsonar.language=java \
                        -Dsonar.java.binaries=target/classes \
                        -Dsonar.java.libraries=target/*.jar"
                }
                // timeout(time: 2, unit: 'MINUTES') {
                //     waitForQualityGate abortPipeline: true
                // }
            }
        }

        stage ('Maven Build') {
            steps {
                sh 'mvn -Dmaven.test.failure.ignore=true clean package' 
            }
            // post {
            //     success {
            //         sh "ls -ltr '${env.WORKSPACE}'"
            //         sh "ls -ltr '${env.WORKSPACE}/target'"
            //     }
            // }
        }

        stage('Artifactory Upload') {
            steps {
                rtUpload (
                    serverId: 'artifact-dev',
                    specPath: 'artifact-upload.json'
                )
            }
        }

        stage('Publish build info') {
            steps {
                rtPublishBuildInfo (
                    serverId: 'artifact-dev'
                )
            }
        }

        stage ('Deploy to App Server') {
            steps{
                sh "sh pre-deploy.sh"
            }
        }
    }
}




