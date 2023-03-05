FROM openjdk:11

#FROM adoptopenjdk/openjdk11:alpine-jre
# Refer to Maven build -> finalName
ARG WAR_FILE=/target/spring-mvc-web-h2-0.0.1-SNAPSHOT.war
# cd /opt/app
WORKDIR /opt/app
# cp target/spring-boot-web.jar /opt/app/app.jar
COPY ${WAR_FILE} spring-mvc-web-h2.war
# java -jar /opt/app/app.jar
ENTRYPOINT ["java","-jar","spring-mvc-web-h2.war"]

#docker build -t spring-mvc-web-h2:1.0.0 .
#docker run -p 8081:8081 -t spring-mvc-web-h2:1.0.0
#docker run -d -p 8081:8081 -t spring-mvc-web-h2:1.0.0
#vdocker build -t spring-web-h2:1 .