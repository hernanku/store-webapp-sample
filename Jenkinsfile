
pipeline {

    agent any
    tools {
        maven 'M3'
        jdk 'java-8'
    }
    stages {
        stage('Clone Repo') {
            steps {
                git branch: 'master', url: "https://github.com/hernanku/store-webapp-sample.git"
            }
        }
        stage('Code Quality Check with SonarQube') {
            environment {
                scannerHome = tool 'sonar_scanner'
            }
            steps {
                withSonarQubeEnv('sonarServer') {
                    sh "${scannerHome}/bin/sonar-scanner \
                        -Dsonar.projectKey=store-app-codeCheck \
                        -Dsonar.host.url=http://sonarqd01.trulabz.com:9000 \
                        -Dsonar.login=d6421646b431030bd7ea671b33d8a71db335da7f \
                        -Dsonar.sources=src/main/java/ \
                        -Dsonar.language=java \
                        -Dsonar.java.binaries=target/classes"
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
                    spec: '''{
                        "files": [
                            {
                                "pattern": "target/*.jar",
                                "target": "dev-java-apps/store-webapp-sample/",
                                "props": "type=jar;status=ready"
                            }
                        ]
                    }''',
                )
            }
        }

        // stage ('Deploy to App Server') {
        //     steps{
        //         sh "sh pre-deploy.sh"
        //     }
        // }
    }
}




