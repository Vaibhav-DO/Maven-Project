Pipeline{
Agent any
	Stages{
		Stage(‘clone’){
			Step(‘clone’){
				git 'https://github.com/Vaibhav-DO/Test.git'
			}
		}
	          Stage(‘compile’){
			Step(‘compile’){
withMaven(globalMavenSettingsConfig: 'null', jdk: 'JAVA_HOME', maven: 'MAVEN_HOME', mavenSettingsConfig: 'null') {
    				sh ‘mvn clean compile’
}
      }	
		}
	Stage(‘deploy to tomcat’){
		Step(‘deploy to tomcat’){
			sshagent(['tomcat']) {
  sh 'scp -o StrictHostKeyChecking=no */target/*.war ec2-              user@3.110.131.223:/var/lib/tomcat/webpages’

}
		}
	  }
}
}	

