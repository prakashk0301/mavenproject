pipeline
{
 agent any
 stages
    {
        stage('scm checkout')
        { steps { git branch: 'master', url: 'https://github.com/prakashk0301/mavenproject.git' }}


        stage('compile the code')  //mnv compile command to compile the code
        { steps { withMaven(globalMavenSettingsConfig: '', jdk: 'JAVA_HOME', maven: 'MAVEN_HOME', mavenSettingsConfig: '', traceability: true) 
          { sh 'mvn compile' }} }    //mvn compile command to compile the code



    
        stage('execute unit test framework')   //mnv test to perform unit testing
        { steps { withMaven(globalMavenSettingsConfig: '', jdk: 'JAVA_HOME', maven: 'MAVEN_HOME', mavenSettingsConfig: '', traceability: true) 
          { sh 'mvn test' }} }  


        stage('generate artifact')   //mnv package to generate artifact
        { steps { withMaven(globalMavenSettingsConfig: '', jdk: 'JAVA_HOME', maven: 'MAVEN_HOME', mavenSettingsConfig: '', traceability: true) 
          { sh 'mvn package' }} }  


       stage('deploy to tomcat')
       {steps { sshagent(['deploytotomcat']) 
        { sh 'scp -o StrictHostKeyChecking=no webapp/target/webapp.war ec2-user@172.31.27.54:/usr/share/tomcat/webapps'  }} }

}
}