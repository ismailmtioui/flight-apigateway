# Use an official OpenJDK runtime as a parent image
FROM openjdk:17-jdk-slim as build

# Set the working directory inside the container
WORKDIR /app

# Copy the Maven wrapper and pom.xml into the container
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .

# Install Maven and build the project
RUN ./mvnw clean package -DskipTests

# Use a smaller base image for the runtime environment
FROM openjdk:17-jdk-slim

# Set the working directory for the runtime container
WORKDIR /app

# Copy the JAR file from the build stage to the container
COPY --from=build /app/target/api-gateway-0.0.1-SNAPSHOT.jar /app/api-gateway.jar

# Expose the port that the app will run on
EXPOSE 8083

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "/app/api-gateway.jar"]
