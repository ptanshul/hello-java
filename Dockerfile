FROM openjdk:8

COPY . .

CMD ["java", "-jar", "app.jar"]

