# docker build phase building application

FROM maven:3.9-eclipse-temurin-17 AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

#stage 2: running phase 

FROM eclipse-temurin:17-jre-jammy
WORKDIR /app
# Copy only the built jar from the builder stage
COPY --from=builder /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
