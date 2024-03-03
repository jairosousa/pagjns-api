#bad practice for dockerized use JDK
#FROM openjdk:17-jdk-slim
#COPY target/springBootDockerized-0.0.1-SNAPSHOT.jar springBootDockerized-0.0.1-SNAPSHOT.jar
#ENTRYPOINT ["java" , "-jar" , "/springBootDockerized-0.0.1-SNAPSHOT.jar"]

FROM maven:3-eclipse-temurin-17 as builder
WORKDIR /extracted
COPY . .
RUN mvn clean package -DskipTests

FROM eclipse-temurin:17.0.5_8-jre-focal
LABEL maintainer="Jairo Nascimento <jaironsousa@gmail.com>"
LABEL version="1.0.0"
LABEL description="My Spring Boot application"

WORKDIR application
COPY --from=builder ./extracted/target/*.jar ./application.jar

EXPOSE 8080

#use it before springboot 3.2
#ENTRYPOINT ["java" , "org.springframework.boot.loader.JarLauncher"]
#use it for after springboot 3.2

ENTRYPOINT java -jar application.jar