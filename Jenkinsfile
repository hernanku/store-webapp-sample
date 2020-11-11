
pipeline {
    environment {
        scannerHome = tool 'sonar-scanner'
    }
    agent {
        node {
            label 'linux-worker-01'
        }
    }  
    // tools {
    //     maven 'M3'
    //     jdk 'java-8'
    // }
    stages {
        stage('Clone Repo') {
            steps {
                git branch: 'feature/pydeploy',
                credentialsId: 'jenkins-github',
                url: 'https://github.com/hernanku/store-webapp-sample.git'
            }
        }
        stage('Code Quality Check with SonarQube') {
            steps {
                script {
                    def sonarScanner = tool name: 'sonar-scanner'
                    withSonarQubeEnv('sonar-scanner') {
                        sh "${scannerHome}/bin/sonar-scanner \
                            -Dsonar.projectKey=webstore-app \
                            -Dsonar.host.url=http://sonarqube01:9000 \
                            -Dsonar.login=d730350485cf7cb50252ed1f66b164ed9b352661 \
                            -Dsonar.sources=src/main/java/ \
                            -Dsonar.language=java \
                            -Dsonar.java.binaries=target/classes \
                            -Dsonar.java.libraries=target/*.jar"
                        }
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
    post { 
        always { 
            cleanWs()
        }
    }
}


