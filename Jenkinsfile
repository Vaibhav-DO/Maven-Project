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
        /*stage('Configuring Docker Server for testing') {
            steps {
                //sh 'ansible-playbook ansible/myrole/deployweb.yml'
                sh 'ansible-playbook ansible/docker.yaml'
            }
        }*/
        stage('Deployment') {
            steps {
                script {
                    dir('kubernetes') {
                        sh "pwd"
                        sh 'ls -la'
                        sh 'aws configure set region us-east-2'
                        sh 'aws eks update-kubeconfig  --region us-west-2   --name myeks'
                        sh 'curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.19.6/2021-01-05/bin/linux/amd64/kubectl'
                        sh 'curl -o kubectl.sha256 https://amazon-eks.s3.us-west-2.amazonaws.com/1.19.6/2021-01-05/bin/linux/amd64/kubectl.sha256'
                                               

                        def mycode = sh(returnStatus: true, script: "openssl sha1 -sha256 kubectl;chmod +x ./kubectl;mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin;echo export PATH=$PATH:$HOME/bin >> ~/.bashrc;kubectl get deployment | grep frontend")
                        
                        //println(mycode.getClass())
                        def key1 = mycode.toString()

                        if (key1 == "0") {
                        
                            echo "Deployment already exist"
                            echo "Deleting it & creating a new one"
                            sh 'openssl sha1 -sha256 kubectl;chmod +x ./kubectl;mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin;echo export PATH=$PATH:$HOME/bin >> ~/.bashrc;kubectl version --short --client;kubectl delete deployment/frontend'

                            sh 'openssl sha1 -sha256 kubectl;chmod +x ./kubectl;mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin;echo export PATH=$PATH:$HOME/bin >> ~/.bashrc;kubectl version --short --client;kubectl create -f deployment.yaml --record;kubectl get deployments'
                            
                            }
                            else {

                                sh 'openssl sha1 -sha256 kubectl;chmod +x ./kubectl;mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin;echo export PATH=$PATH:$HOME/bin >> ~/.bashrc;kubectl version --short --client;kubectl create -f deployment.yaml --record;kubectl get deployments'
                            }

                        def mycode2 = sh(returnStatus: true, script: "openssl sha1 -sha256 kubectl;chmod +x ./kubectl;mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin;echo export PATH=$PATH:$HOME/bin >> ~/.bashrc;kubectl get svc | grep myfrontend-service")

                        //println(mycode2.getClass())
                        def key2 = mycode2.toString()

                            if (key2 == "0") {
                            
                            echo "LoadBalancer Service already Created"
                            sleep(3)
                            echo "Mapped it to your current deployment"
            
                            }
                            else {
                                echo "Launching the LoadBalancer Now"
                                sh "openssl sha1 -sha256 kubectl;chmod +x ./kubectl;mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin;echo export PATH=$PATH:$HOME/bin >> ~/.bashrc;kubectl version --short --client;kubectl create -f LoadBalancer-service.yml --record;kubectl get svc"
                            }
                            sh 'pwd'
                            sleep(5)
                            def mylink1 = sh(script: "chmod +x ./kubectl;mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin;echo export PATH=$PATH:$HOME/bin >> ~/.bashrc;kubectl get svc | grep myfrontend-service | awk '{ print \$4 }'", returnStdout: true)
                            def mylink=mylink1.toString()
                            def mylink_part=/docker_volume/webapp/index_dev.jsp
                            echo mylink
                            echo "Please browse below URL for the PROD APP Service"
                            sh "curl -kv http://${mylink}/${mylink_part}"
                        }
                    }
                }
            }
        }
    }

