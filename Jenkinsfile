pipeline
{
agent any
stages
{

stage ('scm checkout')
{steps {  git branch: 'master', url: 'https://github.com/prakashk0301/mavenproject'   }}

stage('code validate')
{steps { withMaven(globalMavenSettingsConfig: '', jdk: 'JAVA_HOME', maven: 'MAVEN_HOME', mavenSettingsConfig: '', traceability: true) 
{
    sh 'mvn validate'
}  }}


}

}