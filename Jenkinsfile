/* groovylint-disable CompileStatic */
pipeline {
    //agent {label 'linux'}
    agent {
        node {
            label 'linux'
            customWorkspace '/tmp/myefs/myworkspace/workspace/declarative_pipeline'
        }
    }

    environment {
    Node_IP = "18.188.143.4"
    TEST = "Radical"
    sTring = "Webhook created from pipline job"
    }

    stages {
        stage('Git Checkout') {
            steps {
                git branch: 'dev-local-deploy',
                    credentialsId: 'git-https-creds',
                    url: 'https://gitlab.com/andromeda99/maven-project.git'
                }
        }

        stage('Build') {
            steps {
                script {
                    try {
                        sh "whoami"
                        def test1 = "radical1"
                        echo "${TEST}"
                        echo "${test1}"
                        echo "${sTring}"
                        sh '/usr/local/src/apache-maven/bin/mvn clean install'

                    } catch(Exception e) {
                        echo "Exception received because of --- " + e.toString()
                        sh 'exit 1'   
                        } 
                }

            }
        }

        stage('Scanning') {
            steps {
                echo 'Scanning in progress.'
                
            }
        }

        stage('Testing') {
            steps {
                echo 'Testing..'
                sh 'pwd'
                sh 'sudo sh testing.sh'
            }
        }

        stage('Nexus Upload') {
            steps {
                script {
                    try {
                        sh 'date'
                    } catch(Exception e) {
                        echo "Exception received " + e.toString()
                        sh 'exit 1'
                    }
                }
            }
        }

        stage('Deployment') {
            steps {
                script {
                    echo 'Deployment..'
                    sh 'sudo yum install httpd -y'
                    sh 'sudo yum install elinks -y'
                    sh 'sudo systemctl start httpd'
                    sh 'sudo systemctl enable httpd'
                    sh 'sudo rm -rf /var/www/html/*'
                    sh 'sudo rsync -avt ${WORKSPACE}/webapp/target/webapp /var/www/html'
                    sh 'sudo elinks  http://${Node_IP}/webapp/'
                    sh 'sudo elinks  http://${Node_IP}/webapp/index_dev.jsp'
                    sh 'sudo curl -kv http://${Node_IP}/webapp/index_dev.jsp'
                }

            }
        }
    }
}

