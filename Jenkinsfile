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
 stage('create artefact')
 {
    steps 
   {
     withMaven(globalMavenSettingsConfig: '', jdk: 'JAVA_HOME', maven: 'MAVEN_HOME', mavenSettingsConfig: '', traceability: true) {
     sh 'mvn clean package'
   }
 }    
 }  
 stage('deploy_to_tomcat')
{
    steps 
   {
     sshagent(['tomcat']) {
     sh "scp  -o StrictHostKeyChecking=no /opt/maven_data/mavenproject/server/target/server.jar ec2-user@54.159.77.193:/opt/apache-tomcat-9.0.89/webapps" 
      }     
   }    
 }  
 
  // stage("publish to nexus") {
  //           steps {
  //               script {
  //                   // Read POM xml file using 'readMavenPom' step , this step 'readMavenPom' is included in: https://plugins.jenkins.io/pipeline-utility-steps
  //                   pom = readMavenPom file: "pom.xml";
  //                   // Find built artifact under target folder
  //                   filesByGlob = findFiles(glob: "target/*.${pom.packaging}");
  //                   // Print some info from the artifact found
  //                   echo "${filesByGlob[0].name} ${filesByGlob[0].path} ${filesByGlob[0].directory} ${filesByGlob[0].length} ${filesByGlob[0].lastModified}"
  //                   // Extract the path from the File found
  //                   artifactPath = filesByGlob[0].path;
  //                   // Assign to a boolean response verifying If the artifact name exists
  //                   artifactExists = fileExists artifactPath;
                    
  //                   if(artifactExists) {
  //                       echo "*** File: ${artifactPath}, group: ${pom.groupId}, packaging: ${pom.packaging}, version ${pom.version}";
                        
  //                       nexusArtifactUploader(
  //                           nexusVersion: nexus3,
  //                           protocol: http,
  //                           nexusUrl: "3.90.70.179:8081",
  //                           groupId: pom.groupId,
  //                           version: pom.version,
  //                           repository: maven_pranav,
  //                           credentialsId: nexus_pranav,
  //                           artifacts: [
  //                               // Artifact generated such as .jar, .ear and .war files.
  //                               [artifactId: pom.artifactId,
  //                               classifier: '',
  //                               file: artifactPath,
  //                               type: pom.packaging],

  //                               // Lets upload the pom.xml file for additional information for Transitive dependencies
  //                               [artifactId: pom.artifactId,
  //                               classifier: '',
  //                               file: "pom.xml",
  //                               type: "pom"]
  //                           ]
  //                       );

  //                   } else {
  //                       error "*** File: ${artifactPath}, could not be found";
  //                   }
  //               }
  //           }
  //      }
        
  


}

 
}
