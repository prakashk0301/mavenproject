FROM tomcat:10.1.15-jdk21
LABEL app=ui
RUN apt-get update -y 
WORKDIR /usr/local/tomcat/webapps/
COPY webapp/target/webapp.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["catalina.sh", "run"]
