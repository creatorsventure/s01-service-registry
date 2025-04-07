# Use Maven base image to build the project
FROM maven:3.9.9-eclipse-temurin-23 as builder

LABEL org.opencontainers.image.source="https://github.com/creatorsventure/s01-service-registry"

# Set the working directory
WORKDIR /app

# Copy all files
COPY . .

# Download dependencies (this helps take advantage of Docker caching)
RUN mvn dependency:go-offline -B

# Package the application
RUN mvn package -DskipTests

# ---- Create a smaller image for running ----
FROM eclipse-temurin:23-jre

# Set the working directory
WORKDIR /app

# Copy the built jar file from the builder stage
COPY --from=builder /app/target/*.jar app.jar

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]
