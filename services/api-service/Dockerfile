# Stage 1: Build the JAR using Maven
FROM maven:3.9.9-eclipse-temurin-21 AS builder
WORKDIR /app
# Copy pom.xml first for better caching
COPY pom.xml .
# Copy source code - this will invalidate cache when source changes
COPY src ./src
# Add build timestamp to force cache invalidation
ARG BUILD_TIMESTAMP
RUN echo "Build timestamp: ${BUILD_TIMESTAMP:-$(date +%s)}" > /tmp/build.info
# Clean and rebuild - no cache for Maven dependencies
RUN mvn clean package -DskipTests -U

# Stage 2: Run the built JAR
FROM eclipse-temurin:21
WORKDIR /app
COPY --from=builder /app/target/*.jar /app/app.jar
EXPOSE 8081
ENTRYPOINT ["java", "-jar", "app.jar"]

