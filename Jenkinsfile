pipeline
{
agent any
stages
{

stage ('scm checkout')
{steps {  git branch: 'master', url: 'https://github.com/prakashk0301/mavenproject'   }}



stage('code compile')
{steps {withMaven(globalMavenSettingsConfig: '', jdk: 'JAVA_HOME', maven: 'MAVEN_HOME', mavenSettingsConfig: '', traceability: true) 
{
    sh 'mvn compile'
}} }


stage('execute unit test framework')
{steps {withMaven(globalMavenSettingsConfig: '', jdk: 'JAVA_HOME', maven: 'MAVEN_HOME', mavenSettingsConfig: '', traceability: true) 
{
    sh 'mvn test'
}} }

stage('generate artifact or code build')
{steps {withMaven(globalMavenSettingsConfig: '', jdk: 'JAVA_HOME', maven: 'MAVEN_HOME', mavenSettingsConfig: '', traceability: true) 
{
    sh 'mvn package -DskipTests -X'    //skip test, -X for debug or detailed logs
}} }

}

}