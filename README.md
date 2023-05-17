In this blog, we are going to deploy a Java Web app using Maven on a remote Tomcat Server built on an EC2 Instance through the use of Jenkins.

Agenda:

Setup Jenkins
Setup & Configure Maven and Git
Setup Tomcat Server
Integrating GitHub, Maven, and Tomcat Server with Jenkins
Create a CI and CD job
Test the deployment

Prerequisites:

AWS Account
Git/ Github Account with the Source Code
A local machine with CLI Access
Step 1: Setup Jenkins Server on AWS EC2 Instance
Setup a Linux EC2 Instance
Install Java
Install Jenkins
Start Jenkins
Access Web UI on port 8080
Log in to the Amazon management console, open EC2 Dashboard, click on the Launch Instance drop-down list, and click on Launch Instance as shown below:


Once the Launch an instance window opens, provide the name of your EC2 Instance:


For this demo, we will select Amazon Linux 2 AMI which is free tier eligible.


Choose an Instance Type. Here you can select the type of machine, number of vCPUs, and memory that you want to have. Select t2.micro which is free-tier eligible.


For this demo, we will select an already existing key pair. You can create new key pair if you don’t have:


Now under Network Settings, Choose the default VPC with Auto-assign public IP in enable mode. Create a new Security Group, provide a name for your security group, allow ssh traffic, and custom default TCP port of 8080 which is used by Jenkins.


Rest of the settings we will keep them at default and go ahead and click on Launch Instance


On the next screen you can see a success message after the successful creation of the EC2 instance, click on Connect to instance button:


Now connect to instance wizard will open, go to SSH client tab and copy the provided chmod and SSH command:


Open any SSH Client in your local machine, take the public IP of your EC2 Instance, and add the pem key and you will be able to access your EC2 machine in my case I am using MobaXterm on Windows:


After logging in to our EC2 machine we will install Jenkins following the instructions from the official Jenkins website:
https://pkg.jenkins.io/redhat-stable/

To use this repository, run the following command:

sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo

sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key



Now let’s install epel packages for Amazon Linux AMI:


After installing epel packages, let’s install java-openjdk11:


Now let's install Jenkins with the below command as shown in the output:


After successful installation Let's enable and start Jenkins service in our EC2 Instance:


Now let’s try to access the Jenkins server through our browser. For that take the public IP of your EC2 instance and paste it into your favorite browser and should see something like this:


To unlock Jenkins we need to go to the path /var/lib/jenkins/secrets/initialAdminPassword and fetch the admin password to proceed further:


Now on the Customize Jenkins page, we can go ahead and install the suggested plugins:


Now we can create our first Admin user, provide all the required data and proceed to save and continue.


Now we are ready to use our Jenkins Server.


Step 2: Integrate GitHub with Jenkins
Install Git on Jenkins Instance
Install Github Plugin on Jenkins GUI
Configure Git on Jenkins GUI
Let’s first install Git on our EC2 instance with the below command:


We can check the version as shown in the below screenshot:


To install the GitHub plugin lets go to our Jenkins Dashboard and click on manage Jenkins as shown:


On the next page, click on manage plugins:


Now in order to install any plugin we need to select Available Plugins, search for Github Integration, select the plugin, and finally click on Install without restart as shown below:


Now let’s configure Git on Jenkins. Go to Manage Jenkins, and click on Global Tool Configuration.


Under Git installations, provide the name Git, and under Path, we can either provide the complete path where our Git is installed on the Jenkins machine or just put any name, in my case I put Git to allow Jenkins to automatically search for Git. Then click on Save to complete the installation.


Step 3: Integrate Maven with Jenkins
Setup Maven on Jenkins Server
Setup Environment Variables
JAVA_HOME,M2,M2_HOME
Install Maven Plugin
Configure Maven and Java
To install Maven on our Jenkins Server we will switch to the /opt directory and download the Maven package:


Now we will extract the tar.gz file:


Now we will set up Environment Variables for our root user in bash_profile in order to access Maven from any location in our Server Go to the home directory of your Jenkins server and edit the bash_profile file as shown in the below steps:


In the .bash_profile file, we need to add Maven and Java paths and load these values.


To verify follow the below steps:


With this setup, we can execute maven commands from anywhere on the server:


Now we need to update the paths where Java and Maven have been installed in the Jenkins UI. We will first install the Maven Integration Plugin as shown below:


After clicking on Install without restart, go again to manage Jenkins and select Global Tool configuration to set the paths for Java and Maven.


Click on save and hence we have successfully Integrated Java and Maven with Jenkins.

Step 4: Deploy Artifacts on a Tomcat Server
Setup a Linux EC2 Instance
Install Java
Configure Tomcat
Start Tomcat Server
Access Web UI on port 8080
Let’s first create the Amazon Linux 2 EC2 Instance. Here we will skip the steps as we have already seen the creation of EC2 in the earlier steps.

Below is the screenshot of the EC2 Instance:


Let’s first install Java on the Tomcat Server.


Verify the version of Java:


Now let’s first download the Tomcat Server and then install it in the /opt directory:


Now extract the file as:


After extracting, let’s rename the folder as tomcat to make things simpler.

mv apache-tomcat-9.0.74 tomcat
Now move into the tomcat directory, then to /bin directory there we need to run the startup.sh script to run the tomcat services on our Server.


Now in order to make sure that tomcat server Manager App is accessible from anywhere we need to make some changes in a couple of files as initially after the installation the tomcat service Manager App service would be accessible only on the local host on which it is installed:


Now we will update the context.xml file to allow access to Tomcat Server from anywhere apart from the localhost.

First, we will search for the context.xml file in the tomcat directory which is present twice as shown below:


Then after opening the files, we need to comment out a line as shown in the below screenshot:



After making the changes we need to restart the tomcat services:


Now we can access the tomcat server from our browser:


In order to access the Manager App found on the home page of the tomcat server we need to provide credentials. For this, we need to add some Users in the conf/tomcat-users.xml file.

Update the user’s information in the tomcat-users.xml file goto tomcat home directory and Add the below users to conf/tomcat-users.xml file:

 <role rolename="manager-gui"/>
 <role rolename="manager-script"/>
 <role rolename="manager-jmx"/>
 <role rolename="manager-status"/>
 <user username="admin" password="admin" roles="manager-gui, manager-script, manager-jmx, manager-status"/>
 <user username="deployer" password="deployer" roles="manager-script"/>
 <user username="tomcat" password="s3cret" roles="manager-gui"/>


Now we again to restart the services, to make things easier let’s create link files for tomcat startup.sh and shutdown.sh

For that add the below lines and restart the tomcat service:

ln -s /opt/tomcat/bin/startup.sh /usr/local/bin/tomcatup

ln -s /opt/tomcat/bin/shutdown.sh /usr/local/bin/tomcatdown


Now we can access the Manager App on the tomcat server by providing a username: tomcat and password as s3cret


After clicking on the Manager App, provide the credentials and we would be able to see the page below:


Step 5: Integrate Tomcat with Jenkins
Install “Deploy to container” plugin on Jenkins UI
Configure the tomcat server with credentials
Now let’s first install the Deploy to Container plugin. Go to manage Jenkins > Manage Plugins:


Now let’s configure Tomcat with credentials. For that go to Manage Jenkins and under security select Credentials


Click on System:


Then select Global credentials (unrestricted):


On the next screen, Provide the required information, for example under kind select Username and password, etc and select Create to proceed:


Hence this completes the successful integration of Tomcat with Jenkins.

Step 6: Deploy a Java application on a remote Tomcat Server
In this step we would first create a new job in Jenkins, provide the URL of our GitHub repository from where the source code would be pulled, then Maven will be used to build the project and finally, we will deploy the project on the tomcat server all using the CI server named Jenkins.

Here let’s create a new job from scratch:


Now let’s configure our new job. Under General provide the description of your choice:


Under Source Code Management, paste the URL of your GitHub code repository, you can leave the credentials as blank as this is a public repository and mention the branch of your repo, in my case it’s Master.


Under Build Settings, under Root POM mention the pom.xml which should be present in our Git code repository. Under Goals and Options. provide clean install package name which will install the necessary packages and install them in our local repository.


Now we need to deploy our code, so under Build Settings, select Deploy war/ear to a container, and then under Post-build Actions provide the necessary details like a path to the war file, tomcat server credentials, and URL, as shown in the screenshot:


Finally, click on Apply and Save.

Now let’s finally Build our code which would eventually copy the Artifacts to the tomcat server.

Click on Build now on the Jenkins UI to trigger the build:

After clicking on Build Now if we check the console output we can notice that the Build is successful and Jenkins was successfully able to deploy the WAR file onto the tomcat server as shown below:


If we access our tomcat server Manager App we can notice the presence of a new directory named /webapp:


and if we click on the webapp link, it will display the below page:


Hence we have successfully built and deployed our code. However, in this scenario, we have manually built the code and in case there is any change in our code we need to again manually click on the Build Now option in Jenkins and start the process all over again.

Jenkins has provided many options to automate the build trigger process and one of them is Poll SCM.

What is polling the SCM?
“Poll SCM” polls the SCM periodically for checking if any changes/ new commits were made and shall build the project if any new commits were pushed since the last build.

Configure Poll SCM in Jenkins:

Go to the previous job we created in the previous steps and click on configure:


Under Build Triggers, Select the Poll SCM option and set the schedule for the poll to happen. Here we will select the poll that should check every minute, every hour, every day of the month, month, and every day of the week. Click on Apply and Save to proceed.


Now do some changes in your source code and without our intervention the Jenkins build process should be triggered automatically and build the code.

After making some changes in my code the build got triggered and checking the console output shows the build has been started by SCM and is successful rather than by the Admin (in an earlier case):


Conclusion
In this blog, we learned how to build a Java web app using GitHub as our SCM, Jenkins as our CI tool, Maven as our build tool, and finally deploying on a remote Tomcat Server.

Resources Used:
GitHub Link: https://github.com/mudasirhaji/Setup-CI-CD-with-Github-Jenkins-Maven-and-Tomcat-on-AWS.git

Credits: Special thanks to Valaxy Technologies for their guidance.

If this blog helped you in any way do let me know in the comments section and please follow and click the clap 👏 button below to show your support 😄

Thanks

Mudasir
