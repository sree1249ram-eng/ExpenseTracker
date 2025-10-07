# Use OpenJDK 17 as the base image
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Copy project files
COPY . /app

# Install Maven to build the WAR
RUN apt-get update && apt-get install -y maven wget && mvn clean package -DskipTests

# Download Tomcat 10
RUN wget https://downloads.apache.org/tomcat/tomcat-10/v10.1.24/bin/apache-tomcat-10.1.24.tar.gz && \
    tar xzf apache-tomcat-10.1.24.tar.gz && \
    mv target/*.war apache-tomcat-10.1.24/webapps/ROOT.war

# Expose port 8080
EXPOSE 8080

# Start Tomcat
CMD ["apache-tomcat-10.1.24/bin/catalina.sh", "run"]
