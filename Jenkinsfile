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
    stage('Parameters'){
			steps {
                script {
					properties([
						parameters([
							[$class: 'ChoiceParameter', 
                                choiceType: 'PT_SINGLE_SELECT', 
                                description: 'Select the Environment from the dropdown List', 
                                filterLength: 1, 
                                filterable: false, 
                                name: 'ENV_DEPLOY', 
								script: [
                                    $class: 'GroovyScript', 
                                    fallbackScript: [
                                        classpath: [], 
                                        sandbox: true, 
                                        script: 
                                            "return['Could not get the ENV_DEPLOY']"
                                    ], 
									script: [
                                        classpath: [], 
                                        sandbox: true, 
                                        script:"return [ 'development', 'test', 'production' ]"
                                    ]									
                                ]
                            ],
							[$class: 'ChoiceParameter', 
                                choiceType: 'PT_SINGLE_SELECT', 
                                description: 'Deploy audit-services project to Kubernetes', 
                                filterLength: 1, 
                                filterable: false, 
                                name: 'DEPLOY_PROJECT', 
								script: [
                                    $class: 'GroovyScript', 
                                    fallbackScript: [
                                        classpath: [], 
                                        sandbox: true, 
                                        script: 
                                            "return['Could not get the DEPLOY_PROJECT']"
                                    ], 
									script: [
                                        classpath: [], 
                                        sandbox: true, 
                                        script:"return [ 'build', 'deploy' ]"
                                    ]									
                                ]
                            ],
                        ])
                    ])
                }
            }
        }
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
               sh "cp ./target/*.war /Users/hari/MyWork/Softwares/Servers/apache-tomcat-9.0.73/webapps/"
               sh "/Users/hari/MyWork/Softwares/Servers/apache-tomcat-9.0.73/bin/shutdown.sh"
               sh "/Users/hari/MyWork/Softwares/Servers/apache-tomcat-9.0.73/bin/startup.sh"
           }
       }
       stage('CreateImage'){
         steps{
         	 sh 'pwd'
       		 //sh 'docker build -t harilearning1989/spring-mvc-web-h2:1.0.0 .'
       	 }
       }
    }
}