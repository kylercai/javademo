
# Stage 1: Build the application using Maven
FROM maven:3.9-eclipse-temurin-17 AS build
# Set the working directory
WORKDIR /app
# Copy the Maven project files
COPY pom.xml .
COPY src ./src
# Package the application
RUN mvn clean package -DskipTests

# Stage 2: Run the application using Tomcat 9
FROM tomcat:9.0-jre17
# Create a non-root user to run Tomcat (Kubernetes security best practice)
RUN groupadd -r tomcat && useradd -r -g tomcat -u 1000 tomcat \
    && chown -R tomcat:tomcat /usr/local/tomcat
EXPOSE 8080
RUN rm -fr /usr/local/tomcat/webapps/ROOT
# Copy the built WAR file from the previous stage
COPY --from=build /app/target/javademo.war /usr/local/tomcat/webapps/ROOT.war
RUN chown tomcat:tomcat /usr/local/tomcat/webapps/ROOT.war
USER tomcat
# Health check for container orchestration
HEALTHCHECK --interval=30s --timeout=5s --start-period=60s --retries=3 \
  CMD wget -q -O /dev/null http://localhost:8080/health || exit 1
