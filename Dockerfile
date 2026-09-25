# Stage 1: Build the application
FROM maven:3.8.8-eclipse-temurin-8 AS build

WORKDIR /app

# Copy Maven project files
COPY pom.xml .

# Download dependencies
RUN mvn dependency:go-offline

# Copy source code
COPY src ./src

# Build WAR file
RUN mvn clean package -DskipTests


# Stage 2: Run application using Tomcat
FROM tomcat:9.0-jdk8-temurin

# Remove default Tomcat applications
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR file from build stage
COPY --from=build /app/target/petclinic.war /usr/local/tomcat/webapps/ROOT.war

# Expose Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
