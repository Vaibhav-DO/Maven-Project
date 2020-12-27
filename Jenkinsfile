pipeline {
    agent {label 'linux'}
    
    stages {
        stage('Git Checkout') {
        steps {
            git branch: 'radical',
                credentialsId: 'gitlab-creds-https',
                url: 'https://gitlab.com/andromeda99/maven-project.git'
            }
        }
        stage('Build') {
            steps {
                sh '/usr/local/src/apache-maven/bin/mvn clean install'
            }
        }
        stage('SonarQube Scanning') {
            steps {
                echo 'Sonarqube scanning completed'
            }
        }
        stage('IQ Scanning') {
            steps {
                echo 'IQ scanning completed'
            }
        }
        stage('Testing') {
            steps {
                echo 'Testing..'
                sh 'ls -la'
                sh 'sudo rsync -avt /tmp/myworkspace/workspace/declarative_pipeline/webapp/target/webapp/* /var/www/html'
                sh 'curl -kv http://54.87.0.154/index_dev.jsp'
                
            }
        }
        stage('Deployment') {
            steps {
                echo 'Deployment..'
            }
        }
    }
}
