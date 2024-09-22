# Builder stage
FROM gradle:8.4-jdk21-alpine AS builder
WORKDIR /app
COPY . .
RUN gradle build --no-daemon -x test

# Final stage
FROM openjdk:21-alpine
WORKDIR /app
COPY --from=builder /app/build/libs/*.jar app.jar
EXPOSE 8080
VOLUME /home/istad/media
VOLUME /keys
ENTRYPOINT ["java", "-jar", "-Dspring.profiles.active=dev", "app.jar"]
