# Stage 1: Build the JAR using Maven
FROM maven:3.9.9-eclipse-temurin-21 AS builder
WORKDIR /app
# Copy pom.xml first for better caching
COPY pom.xml .
# Copy source code
COPY src ./src
# Force rebuild by invalidating cache with timestamp
RUN echo "Build timestamp: $(date)" > /tmp/build.info
RUN mvn clean package -DskipTests

# Stage 2: Run the built JAR
FROM eclipse-temurin:21
WORKDIR /app
COPY --from=builder /app/target/*.jar /app/app.jar
EXPOSE 8081
ENTRYPOINT ["java", "-jar", "app.jar"]

