def server = Artifactory.server 'artifact-dev'

pipeline {
    environment {
        scannerHome = tool 'sonar-scanner'
    }

    agent {
        node {
            label 'linux-worker-01'
        }
    }

    tools {
        maven 'mvn3'
        jdk 'jdk8'
        nodejs 'nodejs'
    }
    stages {
        stage('Clone Repo') {
            steps {
                git branch: 'feature/pydeploy',
                credentialsId: 'jenkins-github',
                url: 'https://github.com/hernanku/store-webapp-sample.git'
            }
        }

        stage('Code Quality Check with SonarQube') {
            environment {
                scannerHome = tool 'sonar-scanner'
            }
            steps {
                withSonarQubeEnv('sonar-scanner') {
                    sh "${scannerHome}/bin/sonar-scanner \
                        -Dsonar.projectKey=store-app-codeCheck \
                        -Dsonar.host.url=http://sonarqube01:9000 \
                        -Dsonar.login=b74b9fa40a54037b5231a1a4bf8739127cecd5c3 \
                        -Dsonar.sources=./src/main/java \
                        -Dsonar.language=java \
                        -Dsonar.java.binaries=. \
                        -Dsonar.java.libraries=."
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
                script {
                    def uploadSpec = readFile('artifact-upload.json') 
                    server.upload(uploadSpec) 
                }
            }
        }  

        stage('Publish build info') {
            steps {
                script {
                    def uploadSpec = readFile('artifact-upload.json') 
                    def buildInfo = server.upload uploadSpec
                    server.publishBuildInfo buildInfo
                }
            }
        }
        
        // stage ('Deploy to App Server') {
        //     steps{
        //         sh "sh pre-deploy.sh"
        //                 }
        // }
    }

    post { 
        always { 
            cleanWs()
        }
    }
}


