FROM amazoncorretto:17
WORKDIR /app
COPY /var/lib/jenkins/workspace/first_practice/server/target/server.jar /app/server.jar
CMD ["java", "-jar", "server.jar"]

