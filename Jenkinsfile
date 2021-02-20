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
        stage('Preparing volume for Containers') {
            steps {
                sh 'sudo cp -rf ${WORKSPACE}/webapp /tmp/myefs/docker_volume/'
            }
        }
        stage('Configuring Docker Server for testing') {
            steps {
                //sh 'ansible-playbook ansible/myrole/deployweb.yml'
                sh 'ansible-playbook ansible/docker.yaml'
            }
        }
        stage('Deployment') {
            steps {
                sh 'curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.19.6/2021-01-05/bin/linux/amd64/kubectl'
                sh 'curl -o kubectl.sha256 https://amazon-eks.s3.us-west-2.amazonaws.com/1.19.6/2021-01-05/bin/linux/amd64/kubectl.sha256'
                sh 'openssl sha1 -sha256 kubectl'
                sh 'chmod +x ./kubectl'
                sh 'mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin'
                sh 'echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc'
                sh 'kubectl version --short --client'
                sh 'kubectl create -f deployment-volume-definition.yml'
            }
        }
    }
}
