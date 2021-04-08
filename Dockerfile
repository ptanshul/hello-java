FROM openjdk:8

COPY target/app.jar ./app.jar

CMD ["java", "-jar", "app.jar"]

