
# Stage 1: Build the application using Maven
FROM maven:3.3-jdk-8 AS build
# Set the working directory
WORKDIR /app
# Copy the Maven project files
COPY pom.xml .
COPY src ./src
# Package the application
RUN mvn clean package -DskipTests

# Stage 2: Run the application using Tomcat 8.5
FROM tomcat:8.5-jre8
# Set the working directory
WORKDIR /app
# Copy the built JAR file from the previous stage
COPY --from=build /app/target/javademo.war app.war

EXPOSE 8080
RUN rm -fr /usr/local/tomcat/webapps/ROOT
COPY /app/app.war /usr/local/tomcat/webapps/ROOT.war
