pipeline {
    agent {label 'linux'}

     environment {
        AWS_ACCESS_KEY_ID     = credentials('myawscreds')
        AWS_SECRET_ACCESS_KEY = credentials('myawscreds')
    }
    
    stages {
        stage('Build') {
            steps {
                sh '/usr/local/src/apache-maven/bin/mvn clean install'
            }
        }
        stage('Preparing volume for Containers') {
            steps {
                sh 'sudo cp -rf ${WORKSPACE}/webapp/target/webapp /tmp/myefs/docker_volume/'
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
                script {
                    dir('kubernetes') {
                        sh "pwd"
                        sh 'ls -la'
                        sh 'aws configure set region us-east-2'
                        sh 'aws eks update-kubeconfig --region us-east-2 --name myeks'
                        sh 'curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.21.2/2021-07-05/bin/linux/amd64/kubectl'
                        sh 'curl -o kubectl.sha256 https://amazon-eks.s3.us-west-2.amazonaws.com/1.21.2/2021-07-05/bin/linux/amd64/kubectl.sha256'
                                               

                        def mycode = sh(returnStatus: true, script: "openssl sha1 -sha256 kubectl;chmod +x ./kubectl;mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH;echo 'export PATH=$PATH:$HOME/bin' >> ~/.bash_profile;kubectl get deployment | grep frontend")
                        
                        //println(mycode.getClass())
                        def key1 = mycode.toString()

                        if (key1 == "0") {
                        
                            echo "Deployment already exist"
                            echo "Reconfiguring it as per new changes."
                            
                            sh "chmod +x ./kubectl;mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH;echo 'export PATH=$PATH:$HOME/bin' >> ~/.bash_profile;kubectl version --short --client;kubectl apply -f deployment.yaml --record;kubectl get deployments"
                            
                            }
                            else {

                                sh "chmod +x ./kubectl;mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH;echo 'export PATH=$PATH:$HOME/bin' >> ~/.bash_profile;kubectl version --short --client;kubectl create -f deployment.yaml --record;kubectl get deployments"
                            }

                            def mycode2 = sh(returnStatus: true, script: "openssl sha1 -sha256 kubectl;chmod +x ./kubectl;mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH;echo 'export PATH=$PATH:$HOME/bin' >> ~/.bash_profile;kubectl get svc | grep myfrontend-service")

                            //println(mycode2.getClass())
                            def key2 = mycode2.toString()

                            if (key2 == "0") {
                            
                            echo "LoadBalancer Service already Created"
                            //sleep(3)
                            echo "Mapped it to your current deployment"
            
                            }
                            else {
                                echo "Launching the LoadBalancer Now"
                                sh "openssl sha1 -sha256 kubectl;chmod +x ./kubectl;mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH;echo 'export PATH=$PATH:$HOME/bin' >> ~/.bash_profile;kubectl version --short --client;kubectl create -f LoadBalancer-service.yml --record;kubectl get svc"
                            }
                            sh 'pwd'
                            sleep(5)
                            echo "Please browse below URL for the PROD APP Service"
                            sh "curl -kv http://abeab56bc39244b448475dd691f6eff1-2101201521.us-east-2.elb.amazonaws.com/docker_volume/webapp"
                        }
                    }
                }
            }
        }
    }
