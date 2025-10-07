# Step 1: Build the WAR file using Maven
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Step 2: Deploy the WAR on Tomcat
FROM tomcat:10.1-jdk17
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ExpenseTracker.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
