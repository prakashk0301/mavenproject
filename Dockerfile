FROM tomcat:latest
LABEL author=prakash
WORKDIR /usr/local/tomcat/webapps
COPY webapp/target/webapp.war .
EXPOSE 8080
CMD ["catalina.sh", "run"]