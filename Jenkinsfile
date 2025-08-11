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

    }

}