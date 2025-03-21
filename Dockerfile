FROM maven:3.8.4-openjdk-11 AS build
WORKDIR /app
COPY mvnw pom.xml ./
RUN chmod +x mvnw
RUN ./mvnw clean install -DskipTests
COPY src ./src
RUN ./mvnw package -DskipTests
FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=build /app/target/*.jar /app/app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", ".jar"]