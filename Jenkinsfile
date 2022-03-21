pipeline {
    agent {label 'linux'}

    environment {
        AWS_ACCESS_KEY_ID     = credentials('myawscreds')
        AWS_SECRET_ACCESS_KEY = credentials('myawscreds')
        IMAGE = "myweb"
        VER = "radical-${env.JOB_NAME}-${env.BUILD_ID}"
        DockerHub_repo = "aamirs/radical-private-repo"
    }

    
    stages {
        stage('Git Checkout') {
        steps {
            git branch: 'dev-ansible',
                credentialsId: 'git-https-creds',
                url: 'https://gitlab.com/andromeda99/maven-project.git'
            }
        }
        /*stage('Build') {
            steps {
                sh '/usr/local/src/apache-maven/bin/mvn clean install'
            }
        }
        stage('Preparing volume for Containers') {
            steps {
                sh 'sudo cp -rf ${WORKSPACE}/webapp/target/webapp /tmp/myefs/docker_volume/'
            }
        }
        stage('Launching a Testing VM') {
            steps {
                script {
                    sh "pwd"
                    sh 'ls -la'
                    // Please use below command to set your region which your using to create the instance
                    sh 'aws configure set region us-west-2'

                    // Please use below IP from the subnet you wish to create the instance

                    def mycode = sh(returnStatus: true, script: "aws ec2 describe-instances --filters Name=instance-type,Values=t2.micro --query Reservations[].Instances[].NetworkInterfaces[].PrivateIpAddresses[].PrivateIpAddress | grep 172.31.32.111")

                    
                        
                        //println(mycode.getClass())
                        def key1 = mycode.toString()

                        if (key1 == "0") {
                        
                            echo "Test VM already exist"


                            sh 'aws ec2 describe-instances --filters Name=instance-type,Values=t2.micro --query Reservations[].Instances[].NetworkInterfaces[].PrivateIpAddresses[].PrivateIpAddress | grep 172.31.32.111'
                            
                        }
                            else {

                                echo "VM does not exist. Launching it now..."
                                //sh 'ssh-keygen -R my-dev-box'

                            // Please use image id from the link mentioned on Gitlab -> dev-ansible branch. The image id's are speciic to regions.

                                sh 'aws ec2 run-instances  --image-id ami-06cffe063efe892ad --count 1 --instance-type t2.micro --key-name radical-devops-oregon-12pm-dec-2021 --private-ip-address 172.31.32.111 --security-group-ids sg-0a1a50c23e913fb03 --subnet-id subnet-098ffbbed0fb03a97  --user-data file://user_data_ansible_client.txt'

                                sh 'aws ec2 describe-instances --filters Name=instance-type,Values=t2.micro --query Reservations[].Instances[].NetworkInterfaces[].PrivateIpAddresses[].PrivateIpAddress | grep 172.31.32.111'

                                
                                sh 'sleep 60'
                                
                            }

                    
                    
                }
            }
        }*/
        stage('Configuring Docker Server for testing') {
            steps {
                
                sh "pwd"
                sh "ls -la ansible"
        
                
            }
        }
        stage('Deployment') {
            steps {
                sh 'ansible-playbook ansible/deployment.yml'
            }
        }
    }
}
