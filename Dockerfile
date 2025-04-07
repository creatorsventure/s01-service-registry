# Use a base image with Java (OpenJDK 17 is common for Spring Boot apps)
FROM eclipse-temurin:23-jdk as builder

# Set the working directory
WORKDIR /app

# Copy all files
COPY . .

# Download dependencies (this helps take advantage of Docker caching)
RUN ./mvnw dependency:go-offline -B

# Package the application
RUN ./mvnw package -DskipTests

# ---- Create a smaller image for running ----
FROM eclipse-temurin:23-jre

# Set the working directory
WORKDIR /app

# Copy the built jar file from the builder stage
COPY --from=builder /app/target/*.jar app.jar

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]
