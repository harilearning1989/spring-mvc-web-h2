pipeline{
	agent any
	triggers{
        	pollSCM '*/5 * * * *'
    	}
	//tools {
		//echo "Tools"
		//'org.jenkinsci.plugins.docker.commons.tools.DockerTool' '18.09'
	//}
     environment {
		 FOO = "foo"
		 javaHome = tool name: 'JAVA_HOME', type: 'jdk'
		 javaCMD = "${javaHome}/bin/java"

		 mvnHome = tool name: 'MAVEN_HOME', type: 'maven'
		 //mvnCmd = "${mvnHome}/bin/mvn"
		 mvnCmd = "${mvnHome}/bin"

		 gradleHome = tool name: 'GRADLE_HOME', type: 'gradle'
		 grdlCmd = "${gradleHome}/bin/gradle"
     }
    stages{
       stage('Gradle'){
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
    }
}