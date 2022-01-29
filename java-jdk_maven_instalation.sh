#/bin/bash

#Install Java JDK
cd /opt
wget https://download.java.net/java/GA/jdk13/5b8a42f3905b406298b72d750b6919f6/33/GPL/openjdk-13_linux-x64_bin.tar.gz
tar -xvf openjdk-13_linux-x64_bin.tar.gz
/opt/jdk-13/bin/java -version
echo "export JAVA_HOME=/opt/jdk-13/" >> /root/.bashrc
echo "export PATH=$PATH:/opt/jdk-13/bin" >> /root/.bashrc


# Install Maven
cd /usr/local/src
rm -rf apache-maven*
wget https://mirrors.estointernet.in/apache/maven/maven-3/3.8.4/binaries/apache-maven-3.8.4-bin.tar.gz
tar -xf apache-maven-3.8.4-bin.tar.gz
mv apache-maven-3.8.4/ apache-maven/
echo "export MAVEN_HOME=/usr/local/src/apache-maven" >> /root/.bashrc
echo "export PATH=${MAVEN_HOME}/bin:${PATH}" >> /root/.bashrc
cd /root
bash && source /root/.bashrc 





