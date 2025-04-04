# Use an official OpenJDK image as a base
FROM openjdk:21-jdk-slim

# Set working directory inside the container
WORKDIR /app

# Copy the JAR file from the build output to the container
COPY target/keycloak-admin-service-0.0.1-SNAPSHOT.jar app.jar

# Expose port 8081 (adjust if needed)
EXPOSE 8081

# Run the application
CMD ["java", "-jar", "app.jar"]
