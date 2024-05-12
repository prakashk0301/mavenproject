FROM tomcat
LABEL app=ui
RUN apt-get update -y 
WORKDIR /usr/local/tomcat/webapps/
COPY webapp/target/webapp.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["catalina.sh", "run"]
