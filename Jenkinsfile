pipeline
{ 
    agent any
    stages {
       stage('scm checkout')
       {steps { git branch: 'master', url: 'https://github.com/prakashk0301/mavenproject.git' }}
    
        stage('code compile')
        {steps { sh 'mvn compile' }}

        stage('unit test')
        {steps { sh 'mvn test' }}

        stage('code build')
        {steps { sh 'mvn package' }}

        stage('deploy to tomcat')
        {steps { sshagent(['cicd']) 
         { sh 'scp -o StrictHostKeyChecking=no webapp/target/webapp.war ec2-user@172.31.83.200:/opt/apache-tomcat-10.1.44/webapps'} }

    }

}