Pipeline{
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
	
}
}	

