
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

        stage('Code checkout from github') {
            steps {
                git branch: 'master',
                    credentialsId: 'github_token',
                    url: 'https://github.com/hernanku/store-webapp-sample'
            }
        }

        stage('COde Quality Check SonarQube') {
            steps {
                script {
                    def scannerHomr = tool 'sonar-scanner';
                    withSonarQubeEnv("sonarServer") {
                        sh "${tool(sonar-scanner)}/bin/sonar-scanner \
                        -Dsonar.projectKey=web-app \
                        -Dsonar.sources=. \
                        -Dsonar.css.nodes=. \
                        -Dsonar.host.url=http://sonarqube.trulabz.com:9000 \
                        -Dsonar.login=d6421646b431030bd7ea671b33d8a71db335da7f"
                    }
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




