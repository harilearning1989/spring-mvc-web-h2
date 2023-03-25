pipeline{
	agent any
	triggers{
        	pollSCM '*/5 * * * *'
    	}
	//tools {
		//echo "Tools"
		//'org.jenkinsci.plugins.docker.commons.tools.DockerTool' '18.09'
	//}
	parameters {
		//string defaultValue: 'audit-service', description: 'adding default image name', name: 'IMAGE_DEF_NAME'
		//string defaultValue: '1.0.0-229', description: 'adding default image tag', name: 'IMAGE_DEF_TAG'
		//string defaultValue: 'audit-services', description: 'adding default image name', name: 'ARTIFACTS'
		//string defaultValue: 'Kubernetes', description: 'Choose branch name', name: 'BRANCH_NAME'
        choice choices: ['build', 'deploy'], description: 'Deploy audit-services project to Kubernetes', name: 'DEPLOY_PROJECT'
		choice choices: ['development', 'test', 'production'], description: 'Choose the environment', name: 'ENV_DEPLOY'		
    }
    
     environment {
		 FOO = "foo"
		 javaHome = tool name: 'JAVA_HOME', type: 'jdk'
		 javaCMD = "${javaHome}/bin/java"

		 mvnHome = tool name: 'MAVEN_HOME', type: 'maven'
		 //mvnCmd = "${mvnHome}/bin/mvn"
		 mvnCmd = "${mvnHome}/bin"
                 DOCKERHUB_CREDENTIALS= credentials('dockerid')     
		 //gradleHome = tool name: 'GRADLE_HOME', type: 'gradle'
		 //grdlCmd = "${gradleHome}/bin/gradle"
     }
    stages{
    
       stage('Maven'){
          steps{
             withEnv(["JAVA_HOME=${tool 'JAVA_HOME'}", "PATH=${tool 'JAVA_HOME'}/bin:${env.PATH}"]){
                git credentialsId: 'GitHub', url: 'https://github.com/harilearning1989/spring-mvc-web-h2.git', branch: 'main'
                sh 'java -version'
                echo "Maven"
                sh "${mvnCmd}/mvn -v"
                //sh "mvn clean build"
                sh "${mvnCmd}/mvn clean install -DskipTests=true"
             }
          }
       }      
       
        stage('Deploy'){
           steps{
           	   sh "pwd" 
               //sh "cp ./target/*.war /Users/hari/MyWork/Softwares/Servers/apache-tomcat-9.0.73/webapps/"
               //sh "/Users/hari/MyWork/Softwares/Servers/apache-tomcat-9.0.73/bin/shutdown.sh"
               //sh "/Users/hari/MyWork/Softwares/Servers/apache-tomcat-9.0.73/bin/startup.sh"
           }
       }
	    
        stage('Login to Docker Hub') { 
           steps { 
             script { 
                docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-creds') { 
                docker.login("${DOCKER_HUB_USERNAME}", "${DOCKER_HUB_PASSWORD}") 
          } 
        } 
      }
	    
	    
       stage('CreateImage'){
         steps{
         	 sh 'pwd'
         	 sh 'docker -v'
       		 sh 'docker build -t harilearning1989/spring-mvc-web-h2:1.0.0 .'
		 sh 'docker image tag harilearning1989/spring-mvc-web-h2:1.0.0 9100433025/hariweb:1.0'
		 sh 'docker image push 9100433025/hariweb:1.0'
       	 }
       }
    }
}
