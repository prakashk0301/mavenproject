pipeline
{
agent any
stages
{

stage ('scm checkout')
{agent { label 'DOCKER' }

steps {  git branch: 'master', url: 'https://github.com/prakashk0301/mavenproject'   }}


stage('execute unit test framework')


 {agent { label 'MAVEN' }  //run on maven agent


steps {withMaven(globalMavenSettingsConfig: '', jdk: 'JAVA_HOME', maven: 'MAVEN_HOME', mavenSettingsConfig: '', traceability: true) 
{
sh 'mvn test'   // valitade , compile then run test
}} }

stage('generate artifact and store in local maven repository')

{agent { label 'MAVEN' }

steps {withMaven(globalMavenSettingsConfig: '', jdk: 'JAVA_HOME', maven: 'MAVEN_HOME', mavenSettingsConfig: '', traceability: true) 
{
sh 'mvn clean install -DskipTests'    //skip test, it also generates artifact, clean the workspace folder
}}  }


stage('deploy to multiple tomcat dev')
{parallel
  {


  stage('deploy to tomcat dev1')    //5 min   , this is a parallel stage
  {agent { label 'MAVEN' }
   steps { sshagent (credentials: ['CICD-deploy']) 
     {
      sh 'scp -o StrictHostKeyChecking=no webapp/target/webapp.war ec2-user@172.31.27.88:/usr/share/tomcat/webapps'
    } }} 


    stage('deploy to tomcat dev2')     //5 min, this is a parallel stage
    { agent { label 'MAVEN' }
    steps 
      {   sh 'echo "deploy to dev2" ' }}
    
  } 
 }   

}

}