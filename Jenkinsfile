pipeline
{
agent none
stages
{
 stage('scm checkout')
 { agent { label 'MAVEN' }
  steps { git branch: 'master', url: 'https://github.com/prakashk0301/mavenproject' }}


 stage('code compile')
 { agent { label 'MAVEN' }
steps { withMaven(globalMavenSettingsConfig: '', jdk: 'SLAVE_HOME', maven: 'MAVEN_HOME', mavenSettingsConfig: '', traceability: true)  {
	sh 'mvn compile'
 } }}

  stage('execute unit test framework')
 {agent { label 'MAVEN' }
   steps { withMaven(globalMavenSettingsConfig: '', jdk: 'SLAVE_HOME', maven: 'MAVEN_HOME', mavenSettingsConfig: '', traceability: true)  {
	sh 'mvn test'
 } }}

   stage('code build')
 {agent { label 'MAVEN' }
   steps { withMaven(globalMavenSettingsConfig: '', jdk: 'SLAVE_HOME', maven: 'MAVEN_HOME', mavenSettingsConfig: '', traceability: true)  {
	sh 'mvn package'
 } }}

}
}
