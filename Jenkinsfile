pipeline
{
agent any
stages
{
 stage('scm checkout-clone the code')
 {
    steps 
   {
     git branch: 'master', url: 'https://github.com/Pranav-7670/mavenproject.git'
   }    
 } 
 stage('execute unit test framework')
 {
    steps 
   {
     withMaven(globalMavenSettingsConfig: '', jdk: 'JAVA_HOME', maven: 'MAVEN_HOME', mavenSettingsConfig: '', traceability: true) {
     sh 'mvn test'
    }
 }    
 }  

}

 
}
