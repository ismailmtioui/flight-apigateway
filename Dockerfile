# Use an official OpenJDK runtime as the base image
FROM openjdk:17-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the JAR file into the container
COPY ./target/Api-gateway-0.0.1-SNAPSHOT.jar /app/api-gateway.jar

# Expose the port that the app will run on
EXPOSE 8083

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "/app/api-gateway.jar"]
