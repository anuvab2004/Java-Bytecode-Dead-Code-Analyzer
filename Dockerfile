# Build stage - uses Maven to compile
FROM maven:3.8.4-openjdk-11-slim AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Run stage - uses slim JRE
FROM openjdk:11.0-jre-slim
WORKDIR /app
COPY --from=build /app/target/Java-Bytecode-Dead-Code-Analyzer-*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
